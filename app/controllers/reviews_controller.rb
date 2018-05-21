class ReviewsController < ApplicationController

  def create
    book = params[:book_id]
    @book = Book.find(book)
    @review = current_user.reviews.build(review_params)
    @review.book_id = book
    if @review.save
      redirect_to book_path(@review.book), notice: 'Thanks for Review. It will be published as soon as Admin will approve it.'
    else
      redirect_to book_path(book), alert: @review.errors.full_messages.join(', ')
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :mark)
  end

  def set_book
    params.require(:book_id).permit(:book_id)
  end
end
