class Book < ApplicationRecord
  validates :title, :quantity, :year, :material, :height, :width, :depth, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
