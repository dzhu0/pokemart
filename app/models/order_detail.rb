class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :pokemon_card

    validates :order_id, presence: true
    validates :pokemon_card_id, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.01 }
    validates :quantity, presence: true, numericality: { greater_than: 0 }
end
