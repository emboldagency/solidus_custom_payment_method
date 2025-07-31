# frozen_string_literal: true

module Spree
    class PurchaseOrder < Spree::PaymentSource
        belongs_to :order, class_name: "Spree::Order", optional: true

        def reusable?
            false
        end
    end
end
