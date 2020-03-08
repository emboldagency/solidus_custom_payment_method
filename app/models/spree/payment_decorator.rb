Spree::Payment.class_eval do
  after_create :update_payment_state

  private

  def update_payment_state
    case self.payment_method
    when "Spree::PaymentMethod::CustomCashMethod"
      self.update(:state, :pending)
    end
  end
end
