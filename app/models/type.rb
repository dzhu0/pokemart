class Type < ApplicationRecord
    has_and_belongs_to_many :pokemon_cards

    validates :name, presence: true, uniqueness: true
end
