# frozen_string_literal: true

class Address < ApplicationRecord
  validates :address, :first_name, :last_name, :city, :country, :zip, :phone,
            presence: true

  has_many :orders, foreign_key: :shipping_address_id
  has_many :orders, foreign_key: :billing_address_id
end
