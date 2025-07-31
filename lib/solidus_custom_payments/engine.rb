# frozen_string_literal: true

module SolidusCustomPayments
    class Engine < Rails::Engine
        require "spree/core"
        isolate_namespace Spree
        engine_name "solidus_custom_payments"

        # use rspec for tests
        config.generators do |g|
            g.test_framework(:rspec)
        end

        class << self
            def activate
                Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator.rb")) do |c|
                    Rails.configuration.cache_classes ? require(c) : load(c)
                end
            end

            initializer "spree.payment_method.add_custom_cash_payment_method", after: "spree.register.payment_methods" do |app|
                app.config.spree.payment_methods << Spree::PaymentMethod::CustomCashMethod
            end

            initializer "spree.promotion.rules.add_custom_cash_rule_promotion", after: "spree.promo.register.promotion.rules" do |app|
                app.config.spree.promotions.rules << Spree::Promotion::Rules::CustomCashPaymentMethodRule
            end

            initializer "spree.promotion.rules.add_custom_cash_promotion_actions", after: "spree.promo.register.promotions.actions" do |app|
                app.config.spree.promotions.actions << Spree::Promotion::Actions::CreateNegativeAdjustment
            end

            config.to_prepare(&method(:activate).to_proc)
        end
    end
end
