class CreatePokemonCards < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemon_cards do |t|
      t.string :name
      t.text :description
      t.integer :stock_quantity

      t.timestamps
    end
  end
end
