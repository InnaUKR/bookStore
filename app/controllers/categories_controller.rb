class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show edit update destroy recent]

    def index
      @categories = Category.all
      @books = Book.all.decorate
    end

    def show
      @categories = Category.all
      @books = Book.where(category_id: @category).decorate
    end

    def recent
      @books = Book.resent(@category.id).decorate
      @categories = Category.all
      render action: :index
    end

    def price_low_to_hight
      @books = Book.price_low_to_hight.decorate
      render action: :index
    end

    def price_hight_to_low
      @books = Book.price_hight_to_low.decorate
      render action: :index
    end

    def title_a_z
      @books = Book.title_a_z.decorate
      render action: :index
    end

    def title_z_a
      @books = Book.title_z_a.decorate
      render action: :index
    end

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
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end