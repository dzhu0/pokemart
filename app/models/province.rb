class Province < ApplicationRecord
    has_many :tax_histories
    has_many :customers
    has_many :orders

    validates :name, presence: true, uniqueness: true
end
