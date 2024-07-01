class Order < ApplicationRecord
    belongs_to :customer
    belongs_to :province

    has_many :order_details

    validates :customer_id, presence: true
    validates :province_id, presence: true
    validates :address, presence: true
end
