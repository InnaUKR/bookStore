require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to have_and_belong_to_many(:authors) }
  it { is_expected.to have_many(:line_items) }
  it { is_expected.to belong_to(:category).counter_cache }
  it { is_expected.to have_many(:reviews) }
  it { is_expected.to have_many(:images) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:date_of_publication) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }
  it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:width).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:depth).is_greater_than(0) }

  it { is_expected.to accept_nested_attributes_for :images }

  before(:all) do
    @category = create(:category)
    @book = create(:book,date_of_publication: Date.new(2017, 12, 8), category_id: @category.id)
    @second_book = create(:book, date_of_publication: Date.new(2016, 12, 8), category_id: @category.id)
    @third_book = create(:book, date_of_publication: Date.new(2015, 12, 8), category_id: create(:category).id)
  end

  context '.filter_category' do
    it 'includes books from category' do
      expect(Book.filter_category(@category.id, 'newest_first')).to include(@book, @second_book)
    end

    it 'does not include books from other categories' do
      expect(Book.filter_category(@category.id, 'newest_first')).to_not include(@third_book)
    end

    it 'sorts by date of publication' do
      expect(Book.filter_category(@category.id, 'newest_first')).to
      eq(Book.where(category_id: @category.id).order('date_of_publication DESC'))
    end

    it 'sorts by price' do
      expect(Book.filter_category(@category.id, 'price_low_to_hight')).to
      eq(Book.where(category_id: @category.id).order('price'))
    end

    it 'sorts descending by price' do
      expect(Book.filter_category(@category.id, 'price_hight_to_low')).to
      eq(Book.where(category_id: @category.id).order('price DESC'))
    end

    it 'sorts by title' do
      expect(Book.filter_category(@category.id, 'title_a_z')).to
      eq(Book.where(category_id: @category.id).order('title'))
    end

    it 'sorts descending by title' do
      expect(Book.filter_category(@category.id, 'title_z_a')).to
      eq(Book.where(category_id: @category.id).order('title DESC'))
    end
  end

  it '.best_sellers' do
    user = create(:user)
    user.orders.first.line_items.create(book_id: @book.id, quantity: 5)
    user.orders.first.line_items.create(book_id: @second_book.id, quantity: 4)
    user.orders.first.line_items.create(book_id: @third_book.id, quantity: 3)
    expect(Book.best_sellers).to eq([@book, @second_book, @third_book])
  end

  it '.latest_books' do
    latest_books = [@book, @second_book, @third_book]
    expect(Book.latest_books).to eq(latest_books)
  end

  it '.latest_books' do
    latest_books = [@third_book, @second_book, @book]
    expect(Book.latest_books).to_not eq(latest_books)
  end

  context '.filter' do
    it 'newest_first' do
      expect(Book.filter('newest_first')).to eq(Book.order('date_of_publication DESC'))
    end

    it 'price_low_to_hight' do
      expect(Book.filter('price_low_to_hight')).to eq(Book.order('price'))
    end

    it 'price_hight_to_low' do
      expect(Book.filter('price_hight_to_low')).to eq(Book.order('price DESC'))
    end

    it 'title_a_z' do
      expect(Book.filter('title_a_z')).to eq(Book.order('title'))
    end

    it 'title_z_a' do
      expect(Book.filter('title_z_a')).to eq(Book.order('title DESC'))
    end
  end
end