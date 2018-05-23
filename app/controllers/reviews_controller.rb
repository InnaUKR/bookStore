class ReviewsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @review = current_user.reviews.build(review_params)
    @review.book_id = @book.id
    if @review.save
      redirect_to book_path(@book), notice: 'Thanks for Review. It will be published as soon as Admin will approve it.'
    else
      redirect_to book_path(@book), alert: @review.errors.full_messages.join(', ')
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :score)
  end

  def set_book
    params.require(:book_id).permit(:book_id)
  end
end
