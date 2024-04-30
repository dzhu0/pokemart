class AddPokemonCardRefToPriceHistories < ActiveRecord::Migration[7.1]
  def change
    add_reference :price_histories, :pokemon_card, null: false, foreign_key: true
  end
end
