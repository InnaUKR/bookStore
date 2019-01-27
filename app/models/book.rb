class Book < ApplicationRecord
  FILTERS = { newest_first: 'date_of_publication DESC',
              price_low_to_hight: 'price',
              price_hight_to_low: 'price DESC',
              title_a_z: 'title',
              title_z_a: 'title DESC' }.freeze
  DEFAULT_FILTER = :newest_first

  has_and_belongs_to_many :authors
  has_many :line_items
  belongs_to :category, counter_cache: true
  has_many :reviews
  has_many :images, as: :imageable

  validates :title, :date_of_publication, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :height, :width, :depth, numericality: { greater_than: 0 }

  accepts_nested_attributes_for :images, limit: 4

  scope :filter_category, ->(category, filter) { where(category_id: category).order(FILTERS[filter.to_sym]) }
  scope :filter, ->(filter) { order(FILTERS[filter.to_sym]) }
  scope :latest_books, -> { order(created_at: :desc) }

  def self.best_sellers
    find_by_sql(" SELECT books.*
                  FROM books
                  INNER JOIN line_items ON books.id = line_items.book_id
                  GROUP BY books.id
                  ORDER BY SUM(line_items.quantity) desc;")
  end
end
