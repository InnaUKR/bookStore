class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  validates :title, :material, :height, :width, :depth, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  scope :resent, -> { order('date_of_publication DESC') }
  scope :price_low_to_hight, ->{ order('price') }
  scope :price_hight_to_low, ->{ order('price DESC') }
  scope :title_a_z, ->{ order(:title)}
  scope :title_z_a, ->{ order('title DESC')}

  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
    end
    throw :abort
  end
end
