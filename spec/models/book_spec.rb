require 'rails_helper'
require 'faker'

RSpec.describe Book, :type => :model do
  describe 'validations' do
    before do
      @title = Faker::Book.title
      @book = Book.create(
          title: @title,
          quantity: Faker::Number.digit,
          year: Date.today,
          material: Faker::Commerce.material,
          height: Faker::Number.between(0.00, 10.00),
          width: Faker::Number.between(0.00, 10.00),
          depth: Faker::Number.between(0.00, 10.00),
          price: Faker::Commerce.price
      )
    end

    context 'is valid' do
      it 'with a first name, last name, email, and password' do
        expect(@book).to be_valid
      end
    end

    context 'is not valid' do
      it 'without a title' do
        book = Book.new(title: nil)
        book.valid?
        expect(book.errors[:title]).to include("can't be blank")
      end
      it 'does not allow duplicate book titles' do
        new_book = Book.new(title: @title)
        new_book.valid?
        expect(new_book.errors[:title]).to include('has already been taken')
      end
      it 'without a quantity' do
        book = Book.new(quantity: nil)
        book.valid?
        expect(book.errors[:quantity]).to include("can't be blank")
      end
      it 'without a year' do
        book = Book.new(year: nil)
        book.valid?
        expect(book.errors[:year]).to include("can't be blank")
      end
      it 'without a material' do
        book = Book.new(material: nil)
        book.valid?
        expect(book.errors[:material]).to include("can't be blank")
      end
      it 'without a height' do
        book = Book.new(height: nil)
        book.valid?
        expect(book.errors[:height]).to include("can't be blank")
      end
      it 'without a width' do
        book = Book.new(width: nil)
        book.valid?
        expect(book.errors[:width]).to include("can't be blank")
      end
      it 'without a depth' do
        book = Book.new(depth: nil)
        book.valid?
        expect(book.errors[:depth]).to include("can't be blank")
      end
      it 'without a price' do
        book = Book.new(price: nil)
        book.valid?
        expect(book.errors[:price]).to include("is not a number")
      end
      it 'with a negative price' do
        book = Book.new(price: -5)
        book.valid?
        expect(book.errors[:price]).to include("must be greater than or equal to 0.01")
      end
      it 'with a price less than 0.01' do
        book = Book.new(price: 0.001)
        book.valid?
        expect(book.errors[:price]).to include("must be greater than or equal to 0.01")
      end
    end
  end
end


