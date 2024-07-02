class CreateOrderDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :order_details do |t|
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
