class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :set_review_params, only: %i[show]
  skip_authorization_check only: %i[index show]

  def show
    @reviews = Review.approved_reviews(@book).decorate
    @item = @book.line_items.build
  end

  def change_quantity
    @book = Book.find(params[:book_id]).decorate
    quantity = params[:quantity].to_i
    if quantity > 1
      @review = @book.reviews.build
      @reviews = Review.approved_reviews(@book).decorate
      @item = @book.line_items.build(quantity: quantity)
      render 'books/show'
    else
      redirect_to @book, alert: t('books_controller.quantity_eq_0')
    end
  end

  private

  def set_book
    @book = Book.find(params[:id]).decorate
  end

  def set_review_params
    if params.include?(:review)
      @review = @book.reviews.build(params.require(:review).permit(:title, :text, :score))
    else
      @review = @book.reviews.build
    end
  end

  def book_params
    params.require(:book).permit(:title, :price, :description,
                                 :date_of_publication, :height, :width, :depth,
                                 :material, :category_id,
                                 images_attributes: [:image])
  end
end
