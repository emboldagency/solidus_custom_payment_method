# frozen_string_literal: true

module CustomCashMethod
  module Spree::AdjustmentDecorator
    def self.prepended(base)
      base.scope :not_forced, -> { !eligibility_forced? }
    end
  
    def custom_eligibilty_check_for_promotion
      if eligibility_forced?
        self.eligible = eligibility_forced?
      else
        self.eligible = calculate_eligibility
      end
    end
  
    def eligibility_forced?
      negative_eligibility_forced? || payment_eligibility_forced?
    end
  
    def not_eligibility_forced_and_eligible?
      !eligibility_forced? && eligible?
    end
  
    def payment_eligibility_forced?
      custom_payment_method_rules = ["Spree::Promotion::Rules::CustomCashPaymentMethodRule"]
      promotion_rules  =  self.source.try(:promotion).try(:rules)
      promotion_rules_types = promotion_rules.try(:map, &:type)
      if (promotion_rules_types.present? && ((promotion_rules_types - custom_payment_method_rules).length != promotion_rules_types.length))
        last_payment = self.order.payments.last
        if last_payment.present?
          payment_method_id = last_payment.payment_method_id
          promotion_rules.map(&:payment_promotion_rules).flatten.map(&:payment_method_id).include? payment_method_id
        else
          false
        end
      else
        false
      end
    end
  
    def negative_eligibility_forced?
      custom_payment_method_actions = ["Spree::Promotion::Actions::CreateNegativeAdjustment"]
      promotion_actions = self.source.try(:promotion).try(:actions)
      promotion_action_types = promotion_actions.try(:map, &:type)
      promotion_rules  =  self.source.try(:promotion).try(:rules)
      promotion_rules_types = promotion_rules.try(:map, &:type)
  
      (promotion_action_types.present? && ((promotion_action_types - custom_payment_method_actions).length != promotion_action_types.length)) && self.source.promotion.eligible?(adjustable)
    end
  
  
    # Calculates based on attached promotion (if this is a promotion
    # adjustment) whether this promotion is still eligible.
    # @api private
    # @return [true,false] Whether this adjustment is eligible
    def calculate_eligibility
      if !finalized? && source && promotion?
        source.promotion.eligible?(adjustable, promotion_code: promotion_code)
      else
        eligible?
      end
    end
  
    # Recalculate and persist the amount from this adjustment's source based on
    # the adjustable ({Order}, {Shipment}, or {LineItem})
    #
    # If the adjustment has no source (such as when created manually from the
    # admin) or is closed, this is a noop.
    #
    # @return [BigDecimal] New amount of this adjustment
    def recalculate
      if finalized? && !tax?
        return amount
      end
  
      # If the adjustment has no source, do not attempt to re-calculate the
      # amount.
      # Some scenarios where this happens:
      #   - Adjustments that are manually created via the admin backend
      #   - PromotionAction adjustments where the PromotionAction was deleted
      #     after the order was completed.
      if source.present?
        self.amount = source.compute_amount(adjustable)
  
        if promotion?
          custom_eligibilty_check_for_promotion
        end
  
        # Persist only if changed
        # This is only not a save! to avoid the extra queries to load the order
        # (for validations) and to touch the adjustment.
        update_columns(eligible: eligible, amount: amount, updated_at: Time.current) if changed?
      end
      amount
    end
  
    ::Spree::Adjustment.prepend self
  end
end
