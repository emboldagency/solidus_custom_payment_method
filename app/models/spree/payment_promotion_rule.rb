# frozen_string_literal: true

class Spree::PaymentPromotionRule < ApplicationRecord
    belongs_to :payment_method
    belongs_to :promotion_rule
end
