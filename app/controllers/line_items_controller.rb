class LineItemsController < ApplicationController
  before_action :set_line_item, only: %I[show edit update destroy up_quantity down_quantity]

  def new
    @line_item = LineItem.new
  end

  def create
    book = Book.find(params[:book_id] || params[:line_items][:book_id])
    quantity = params[:line_items][:quantity].to_i || 1
    @line_item = current_cart.add_book(book, quantity)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'Book was successfully added to cart.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Book item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @line_item.cart, notice: 'Book item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def up_quantity
    @line_item.increment!(:quantity)
    redirect_to @line_item.cart
  end

  def down_quantity
    if @line_item.quantity > 1
      @line_item.decrement!(:quantity)
      redirect_to @line_item.cart
    else
      @cart = current_cart.decorate
      @line_items = LineItemDecorator.decorate_collection(@cart.line_items)
      render 'carts/show'
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id] || params[:line_item_id])
  end

  def line_item_params
    params.require(:line_item).permit(:book_id, :quantity)
  end


end
