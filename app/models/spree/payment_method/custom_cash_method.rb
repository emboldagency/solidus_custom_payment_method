class Spree::PaymentMethod::CustomCashMethod < Spree::PaymentMethod::Check
  def auto_capture
    false
  end
end
