class Spree::PaymentMethod::CustomCashMethod < Spree::PaymentMethod::Check
  has_many :adjustments, as: :adjustable

  def gateway_class
    self.class
  end

  def authorize(money, source, gateway_options)
    payment = gateway_options[:originator]
    order = payment.order
    binding.pry
    # active_merchant_response(adyen_client.checkout.payments(args))
  end

  def capture(amount, transaction_details, gateway_options = {})
    payment = gateway_options[:originator]
    # active_merchant_response(adyen_client.payments.capture(args))
  end

  def purchase(money, source, gateway_options)
    raise StandardError, "Not implemented"
  end

  def cancel(transaction_details)
    payment = Spree::Payment.where(response_code: transaction_details).first
    binding.pry
    # active_merchant_response(adyen_client.payments.cancel(args))
  end

  def credit(amount_in_cents, transaction_details, gateway_options = {}) # AKA refund
    payment = Spree::Payment.where(response_code: transaction_details).first
    binding.pry
    # active_merchant_response(adyen_client.payments.refund(args))
  end

  def auto_capture
    false
  end

  private

  def handle_error(error)
    ActiveMerchant::Billing::Response.new(false, error, { message: error }, test: !Rails.env.production?)
  end

  def active_merchant_response(adyen_result)
    binding.pry
    ActiveMerchant::Billing::Response.new(flag, message, { message: message }, test: !Rails.env.production?)
  end
end
