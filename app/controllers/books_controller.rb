class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.all.decorate
    @categories = Category.all
  end

  def show
    @review = @book.reviews.build
    @reviews = Review.approved_reviews(@book)
  end

  def new
    @book = Book.new
    @images = @book.build_images
  end

  def edit; end

  def create
    begin
      @book = Book.new(book_params)

      respond_to do |format|
        if @book.save
          format.html { redirect_to @book, notice: 'Book was successfully created.' }
        else
          format.html { render :new }
        end
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords
      flash[:error] = 'Too many images'
    end
  end

  def update
    begin
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    rescue ActiveRecord::NestedAttributes::TooManyRecords
      flash[:error] = 'Too many images'
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id]).decorate
  end

  def book_params
    params.require(:book).p
    ermit(:title, :price, :description,
                                 :date_of_publication, :height, :width, :depth,
                                 :material, :category_id,
                                 images_attributes: [:image])
  end
end
