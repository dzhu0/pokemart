class AddFieldsToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :username, :string
    add_column :customers, :address, :string
    add_reference :customers, :province
  end
end
