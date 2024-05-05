class CreatePriceHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :price_histories do |t|
      t.decimal :price

      t.timestamps
    end
  end
end
