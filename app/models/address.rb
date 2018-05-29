class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  validates :address, :first_name, :last_name, :city, :country, :zip, :phone,
            presence: true
  validates :address, :first_name, :last_name, :city, :country,
            numericality: { less_than: 50 }
  validates :first_name, :last_name, :city, :country,
            format: { with: /\A[a-zA-Z]+\z/ }
  validates :address,
            format: { with: /\A[a-zA-Z0-9\s,-]+\z/ }
  validates :zip,
            format: { with: /\A[0-9]+\z/ },
            length: { maximum: 10 }
  validates :phone,
            format: { with: /\A\+[\d]{3}[0-9]+\z/ },
            numericality: { less_than_or_equal_to: 15 }
end
