class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :pokemon_card
end
