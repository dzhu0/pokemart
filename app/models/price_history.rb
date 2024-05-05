class PriceHistory < ApplicationRecord
    belongs_to :pokemon_card

    validates :pokemon_card_id, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
end
