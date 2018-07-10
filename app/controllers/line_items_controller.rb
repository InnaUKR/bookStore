class LineItemsController < ApplicationController
  before_action :set_line_item, only: %I[destroy show edit update up_quantity down_quantity]
  def new
    @line_item = LineItem.new
  end

  def create
    @line_item = current_order.add_book(line_item_params)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to current_order, notice: 'Book was successfully added to cart.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item)
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
    redirect_to current_order, notice: 'Book item was successfully destroyed.'
  end

  def up_quantity
    @line_item.increment!(:quantity)
    redirect_to current_order
  end

  def down_quantity
    if @line_item.quantity > 1
      @line_item.decrement!(:quantity)
      redirect_to current_order
    else
      render 'orders/show', notice: "Quantity can't be less than 1. Use X button if you want delet ."
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
