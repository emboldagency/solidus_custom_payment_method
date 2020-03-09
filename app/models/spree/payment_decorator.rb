Spree::Payment.class_eval do
  after_create :set_correct_amount
  private

  def set_correct_amount
    Spree::PromotionHandler::Cart.new(self.order).activate
    self.order.recalculate
    self.amount = self.order.total
    self.save(validate: false)
  end
end
