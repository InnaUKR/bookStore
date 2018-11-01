class OrdersController < ApplicationController
  before_action :set_order, only: [:update, :destroy]
  before_action :set_cart, only: :cart

  authorize_resource

  rescue_from CanCan::AccessDenied do
    redirect_to new_user_session_path
  end

  def index
    if params[:status]
      @orders = current_user.orders.public_send(params[:status]).where.not(id: current_order).decorate
    else
      @orders = current_user.orders.where.not(id: current_order).decorate
    end
  end

  def cart
    @line_items = @order.line_items
  end

  def edit
    session[:current_order_id] = nil if session[:current_order_id].to_i == params[:id].to_i
    session[:order_id] = params[:id]
    redirect_to checkouts_path
  end

  def update
    if coupon
      @order.update(coupon: coupon)
      redirect_to order_cart_path(@order), notice: t('.success')
    else
      redirect_to order_cart_path(@order), alert: t('.unsuccess')
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_cart
    @order = Order.find(params[:order_id]).decorate
  end

  def coupon
    Coupon.find_by(name: params.require(:name))
  rescue NoMethodError, ActionController::ParameterMissing
    nil
  end
end