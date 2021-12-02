# frozen_string_literal: true

module Spree::PaymentDecorator
  def self.prepended(base)
    base.after_create :set_correct_amount
  end

  private

  def set_correct_amount
    Spree::PromotionHandler::Cart.new(self.order).activate
    self.order.recalculate
    self.amount = self.order.total
    self.save(validate: false)
  end

  ::Spree::Payment.prepend self
end