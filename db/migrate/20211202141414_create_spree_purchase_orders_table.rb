class CreateSpreePurchaseOrdersTable < ActiveRecord::Migration[6.1]
  def change
    create_table :spree_purchase_orders, force: :cascade do |t|
      t.string  :po_num
      t.integer :payment_method_id
      t.timestamps
    end
  end
end