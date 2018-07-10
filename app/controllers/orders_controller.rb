class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]
  before_action :set_total_price, only: :create

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = current_order
    @line_items = @order.line_items
  end

  # GET /orders/new
  def new
    @order = current_user.orders.build(total_price: @total_price)
    redirect_to checkout_path(@order)
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = current_user.orders.build
    @order.save
    session[:order_id] = @order.id
    redirect_to checkouts_path
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(coupon_id: coupon_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_total_price
      @total_price = current_user.cart.line_items.sum{|line_item| line_item.quantity * line_item.book.price}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      #order_params = params.require(:orders).permit(:billing_address, :shipping_address, :delivery)
      order_params = {}
      order_params[:coupon_id] = coupon_params
      order_params
    end

  def coupon_params
    Coupon.find_by(name: params[:name]).id
  end
end
