class CartsController < ApplicationController
  def show
    @cart = current_cart.decorate
    @line_items = LineItemDecorator.decorate_collection(@cart.line_items)
  end
end
