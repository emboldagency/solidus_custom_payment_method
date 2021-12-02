class CreateSpreePaymentPromotionRules < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_payment_promotion_rules do |t|
      t.integer :payment_method_id
      t.integer :promotion_rule_id
      t.timestamps
    end
  end
end
