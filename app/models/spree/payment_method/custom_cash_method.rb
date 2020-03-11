class Spree::PaymentMethod::CustomCashMethod < Spree::PaymentMethod::Check
  has_many :payment_promotion_rules, foreign_key: :payment_method_id

  def auto_capture
    false
  end
end
