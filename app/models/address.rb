class Address < ApplicationRecord
  validates :address, :first_name, :last_name, :city, :country, :zip, :phone,
            presence: true

  has_one :user
  has_many :orders
end
