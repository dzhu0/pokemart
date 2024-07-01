class Order < ApplicationRecord
    belongs_to :customer
    belongs_to :province

    has_many :order_details
end
