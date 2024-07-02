class Order < ApplicationRecord
    belongs_to :customer
    belongs_to :province

    has_many :order_details

    validates :customer_id, presence: true
    validates :province_id, presence: true
    validates :address, presence: true

    def total_quantity
        order_details.sum { |item| item.quantity }
    end

    def subtotal
        order_details.sum { |item| item.quantity * item.price }
    end

    def tax_history
        province.tax_histories.where("created_at <= ?", created_at).order(created_at: :desc).first
    end

    def pst
        subtotal * (tax_history&.pst || 0) / 100
    end

    def gst
        subtotal * (tax_history&.gst || 0) / 100
    end

    def hst
        subtotal * (tax_history&.hst || 0) / 100
    end

    def total
        subtotal + pst + gst + hst
    end
end
