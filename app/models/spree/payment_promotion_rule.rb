class Spree::PaymentPromotionRule < ApplicationRecord
  belongs_to :payment_method
  belongs_to :promotion_rule
end
