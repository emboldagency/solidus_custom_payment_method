module Spree
  class Promotion
    module Rules
      class CustomCashPaymentMethodRule < Spree::PromotionRule
        MATCH_POLICIES = %w(all)
        has_many :product_promotion_rules, dependent: :destroy, foreign_key: :promotion_rule_id,
                                           class_name: 'Spree::ProductPromotionRule'
        has_many :products, class_name: 'Spree::Product', through: :product_promotion_rules

        validates_inclusion_of :preferred_match_policy, in: MATCH_POLICIES
        preference :match_policy, :string, default: MATCH_POLICIES.first

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(order, _options = {})
          eligibility_errors = []

          case preferred_match_policy
          when 'all'
            last_payment = order.payments.last
            eligibility_errors << "Not custom cash method payment" if last_payment.try(:payment_method).try(:type) != "Spree::PaymentMethod::CustomCashMethod"
          else
            raise "unexpected match policy: #{preferred_match_policy.inspect}"
          end

          eligibility_errors.empty?
        end

        def actionable?(line_item)
          # ONLY WHOLE ORDER ADJUSTMENT
          return false
        end
      end
    end
  end
end
