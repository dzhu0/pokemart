class Contact < ApplicationRecord
    validates :title, presence: true
    validates :email, presence: true, format: { with: /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+\z/, message: "is invalid" }
    validates :phone, presence: true, format: { with: /\A[\+]?\d{0,3}[(]?\d{3}[)]?[-\s\.]?\d{3}[-\s\.]?\d{4}\z/, message: "is invalid" }
end
