class CreateJoinTablePokemonCardType < ActiveRecord::Migration[7.1]
  def change
    create_join_table :pokemon_cards, :types do |t|
      # t.index [:pokemon_card_id, :type_id]
      # t.index [:type_id, :pokemon_card_id]
    end
  end
end
