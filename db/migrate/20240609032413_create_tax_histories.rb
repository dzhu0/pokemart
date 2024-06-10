class CreateTaxHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :tax_histories do |t|
      t.decimal :pst
      t.decimal :gst
      t.decimal :hst

      t.timestamps
    end
  end
end
