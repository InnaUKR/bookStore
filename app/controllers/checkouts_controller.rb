class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  steps :delivery, :payment, :confirm, :complete
  before_action :set_step, only: :show
  before_action :order, only: :update

  def show
    @form = "#{step.capitalize}Form".constantize
    render_wizard
  end

  def update
    capital_step = step.to_s.capitalize
    form_name = "#{capital_step}Form".constantize
    @form = form_name.from_params(order_params).with_context(order: @order)
    render_wizard @form
  end

  private

  def order_params
    params.require(:order).permit(:delivery_id)
  end

  def order
    order_id = session[:order_id]
    @order = Order.find(order_id)
  end

  def set_step
    order
    params[:id] = @order.step || step
  end
end
