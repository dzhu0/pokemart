class PokemonCard < ApplicationRecord
    has_and_belongs_to_many :types
    has_many :price_histories

    has_one_attached :image
end
