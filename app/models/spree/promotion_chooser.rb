# frozen_string_literal: true

module Spree
    class PromotionChooser
        def initialize(adjustments)
            @adjustments = adjustments
        end

        # Picks the best promotion from this set of adjustments, all others are
        # marked as ineligible.
        #
        # @return [BigDecimal] The amount of the best adjustment
        def update
            if best_promotion_adjustment
                @adjustments.select(&:eligible?).each do |adjustment|
                    adjustment.update(eligible: true, updated_at: Time.current) && next if adjustment.eligibility_forced?
                    next if adjustment == best_promotion_adjustment

                    adjustment.update(eligible: false, updated_at: Time.current)
                end
                best_promotion_adjustment.amount
            else
                BigDecimal("0")
            end
        end

        private

        # @return The best promotion from this set of adjustments.
        def best_promotion_adjustment
            @best_promotion_adjustment ||= @adjustments.select(&:not_eligibility_forced_and_eligible?).min_by do |a|
                [a.amount, -a.id]
            end
        end
    end
end
