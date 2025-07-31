# frozen_string_literal: true

module Spree
    module PaymentMethod
        class CustomCashMethod < Spree::PaymentMethod::Check
            has_many :payment_promotion_rules, foreign_key: :payment_method_id, dependent: :destroy, inverse_of: :payment_method
            has_many :purchase_orders, class_name: "Spree::PurchaseOrder", dependent: :destroy, inverse_of: :payment_method
            # belongs_to :orders, foreign_key: :order_id

            def payment_source_class
                Spree::PurchaseOrder
            end

            def auto_capture
                false
            end
        end
    end
end
