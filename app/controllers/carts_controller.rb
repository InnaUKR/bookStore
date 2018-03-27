class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :update, :destroy]

  def show
    @cart = Cart.find(params[:id]).decorate
    @line_items = LineItemDecorator.decorate_collection(@cart.line_items)
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:card_id] = @cart.id
  end

  def cart_params
    params.fetch(:cart, {})
  end
end
