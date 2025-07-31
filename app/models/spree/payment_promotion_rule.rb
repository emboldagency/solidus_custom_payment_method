# frozen_string_literal: true

module Spree
    class PaymentPromotionRule < ApplicationRecord
        belongs_to :payment_method
        belongs_to :promotion_rule
    end
end
