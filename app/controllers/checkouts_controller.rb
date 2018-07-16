class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  steps :delivery, :payment, :confirm, :complete
  STEPS = [:delivery, :payment, :confirm, :complete]
  before_action :order, only: [:index, :update, :show]

  def index
    step = @order.step || steps.first
    jump_to step
    render_wizard
  end

  def show
    @form = "#{step.capitalize}Form".constantize.new
    render_wizard
  end

  def update
    @form = "#{step.capitalize}Form".constantize
    params = send("#{step}_params")
    @form.from_params(params || {})
    if @form.valid?
      @form.update!(@order)
      if !@order.step || STEPS.index(@order.step.to_sym) < STEPS.index(next_step)
        @order.update(step: next_step)
      end
      jump_to(@order.step)
    end
    render_wizard @form
  end

  private

  def delivery_params
    params.require(:order).permit(:delivery_id)
  end

  def payment_params
    params.require(:order).require(:credit_card).permit(:number, :card_name, :cvv, :exp_date)
  end

  def confirm_params; end

  def order
    @order = Order.find(session[:order_id])
  end
end
