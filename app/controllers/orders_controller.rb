class OrdersController < ApplicationController
  before_action :set_order, only: [:update, :destroy]

  def show
    @order = current_order
    @line_items = @order.line_items
  end

  def edit
    session[:order_id] = params[:id]
    redirect_to checkouts_path
  end

  def update
    if @order.update(coupon_id: coupon_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def coupon_params
    Coupon.find_by(name: params[:name]).id
  end
end