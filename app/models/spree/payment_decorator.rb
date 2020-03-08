Spree::Payment.class_eval do
  before_create :update_payment_state

  private

  def update_payment_state
    case self.payment_method.try(:type)
    when "Spree::PaymentMethod::CustomCashMethod"
      self.state = :pending
    end
  end
end
