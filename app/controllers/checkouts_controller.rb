class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  steps :delivery, :payment, :confirm, :complete
  before_action :set_step, only: :show
  before_action :order, only: :update

  def show
    @form = "#{@step.to_s.capitalize}Form".constantize.new
    render @step
  end

  def update
    capital_step = step.capitalize
    form_name = "#{capital_step}Form".constantize
    params = send("#{step}_params")
    @form = form_name.from_params(params).with_context(order: @order,
                                                       user: current_user,
                                                       step: next_step)
    render_wizard @form
  end

  private

  def delivery_params
    params.require(:order).permit(:delivery_id)
  end

  def payment_params
    params.require(:payment).permit(:number, :card_name, :cvv, :exp_date)
  end

  def order
    order_id = session[:order_id]
    @order = Order.find(order_id)
  end

  def set_step
    order
    @step = (params[:step] ? params[:step] : (@order.step || step))
  end
end
