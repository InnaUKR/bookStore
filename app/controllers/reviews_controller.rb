class ReviewsController < ApplicationController
  before_action :set_book, only: :create
  authorize_resource

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to book_path(@book), notice: 'Thanks for Review. It will be published as soon as Admin will approve it.'
    else
      redirect_to book_path(@book, review: review_params), alert: @review.errors.full_messages.join(', ')
    end
  end

  private

  def review_params
    review_params = params.require(:review).permit(:title, :text, :score)
    review_params[:book_id] = @book.id
    review_params
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
