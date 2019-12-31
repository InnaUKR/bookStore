# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :set_line_item, only: %I[destroy up_quantity]
  before_action :set, only: %I[down_quantity]
  authorize_resource

  def new
    @line_item = LineItem.new
  end

  def create
    @line_item = current_order.add_book(line_item_params)
    @line_item.save
    redirect_to order_cart_path(current_order), notice: t('.success')
  end

  #   def update
  #     respond_to do |format|
  #       if @line_item.update(line_item)
  #         redirect_to @line_item, notice: 'Book item was successfully updated.'
  #       else
  #         render :edit
  #       end
  #     end
  #   end

  def destroy
    @line_item.destroy
    redirect_back(fallback_location: root_path, notice: t('.success'))
  end

  def up_quantity
    @line_item.increment!(:quantity)
    redirect_to order_cart_path(@line_item.order)
  end

  def down_quantity
    if @line_item.quantity > 1
      @line_item.decrement!(:quantity)
      redirect_to order_cart_path(@line_item.order)
    else
      redirect_to order_cart_path(@line_item.order), alert: t('.unsuccess')
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id] || params[:line_item_id])
  end

  def set
    @line_item = LineItem.find(params[:line_item_id])
  end

  def line_item_params
    params.require(:line_item).permit(:book_id, :quantity)
  end
end
