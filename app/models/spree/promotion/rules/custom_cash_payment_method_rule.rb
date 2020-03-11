module Spree
  class Promotion
    module Rules
      class CustomCashPaymentMethodRule < Spree::PromotionRule
        MATCH_POLICIES = %w(all)
        has_many :payment_promotion_rules, dependent: :destroy, foreign_key: :promotion_rule_id, class_name: "Spree::PaymentPromotionRule"
        has_many :payment_methods, class_name: "Spree::PaymentMethod::CustomCashMethod", through: :payment_promotion_rules

        validates_inclusion_of :preferred_match_policy, in: MATCH_POLICIES
        preference :match_policy, :string, default: MATCH_POLICIES.first

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(order, _options = {})
          eligibility_errors = []
          eligibility_errors << "No registered payment methods" if payment_methods.blank?

          case preferred_match_policy
          when 'all'
            last_payment = order.payments.last
            if last_payment.blank?
              eligibility_errors << "No payments yet."
            else
              last_payment_payment_method_type = last_payment.try(:payment_method).try(:type)
              eligibility_errors << "Payment method #{last_payment_payment_method_type} is not supported" if !payment_methods.any? { |payment_method| payment_method.type == last_payment_payment_method_type}
            end
          else
            raise "unexpected match policy: #{preferred_match_policy.inspect}"
          end

          eligibility_errors.empty?
        end

        def actionable?(line_item)
          # ONLY WHOLE ORDER ADJUSTMENT
          return false
        end

        def payment_method_ids_string=(payment_method_ids)
          self.payment_method_ids = payment_method_ids.to_s.split(',').map(&:strip)
        end
      end
    end
  end
end
