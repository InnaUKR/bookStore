class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  validates :title, :quantity, :year, :material, :height, :width, :depth, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
