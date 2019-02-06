# frozen_string_literal: true

class Coupon < ApplicationRecord
  has_many :orders
  validates :name, :amount, presence: true
end
