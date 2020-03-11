class CreateSpreePaymentPromotionRules < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_payment_promotion_rules do |t|
      t.integer :payment_method_id, :integer
      t.integer :promotion_rule_id, :integer
      t.timestamps
    end
  end
end
