class CategoriesController < ApplicationController
  before_action :set_category, only: %i[index]
  before_action :set_filter, only: %i[index]
  def index
    @categories = Category.all
    @books = @category.nil? ? Book.filter(@filter).decorate : Book.filter_category(@category, @filter).decorate
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.html { redirect_to @category, notice: 'Category was successfully created.' }
          format.json { render :show, status: :created, location: @category }
        else
          format.html { render :new }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @category.update(book_params)
          format.html { redirect_to @category, notice: 'Book was successfully updated.' }
          format.json { render :show, status: :ok, location: @category }
        else
          format.html { render :edit }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @category.destroy
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_category
      @category = params[:category]
    end

  def set_filter
    @filter = Book::FILTERS.key?(params[:filter]&.to_sym) ? params[:filter] : Book::DEFAULT_FILTER
  end

    def category_params
      params.require(:category).permit(:name)
    end
end