# frozen_string_literal: true

module Spree
    module PaymentDecorator
        class << self
            def prepended(base)
                base.after_create(:set_correct_amount)
            end
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
