class Province < ApplicationRecord
    has_many :tax_histories
    has_many :customers

    validates :name, presence: true, uniqueness: true
end
