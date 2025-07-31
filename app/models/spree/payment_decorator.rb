# frozen_string_literal: true

module CustomCashMethod
    module Spree::PaymentDecorator
        def self.prepended(base)
            base.after_create(:set_correct_amount)
        end

        private

        def set_correct_amount
            Spree::PromotionHandler::Cart.new(order).activate
            order.recalculate
            self.amount = order.total
            save(validate: false)
        end

        ::Spree::Payment.prepend(self)
    end
end
