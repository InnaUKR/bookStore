class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  steps :address, :delivery, :payment, :confirm, :complete
  before_action :form, only: :update
  before_action :order, only: [:index, :update, :show]
  skip_authorization_check

  def index
    @order.update(step: steps.first) unless @order.step
    jump_to @order.step
    render_wizard
  end

  def show
    @form = "#{step.capitalize}Form".constantize.new
    render_wizard
  end

  def update
    if @form.valid?
      @form.update!(@order)
      set_order_step
      redirect_to wizard_path(@order.step)
    else
      render_wizard @form
    end
  end

  private

  def form_params
    send("#{step}_params")
  rescue NoMethodError, ActionController::ParameterMissing
    {}
  end

  def delivery_params
    params.require(:order).permit(:delivery_id)
  end

  def payment_params
    params.require(:order).require(:credit_card).permit(:number, :card_name, :cvv, :exp_date)
  end

  def address_params
    params.require(:address)
  end

  def form
    @form = "#{step.capitalize}Form".constantize.from_params(form_params)
  end

  def set_order_step
    @order.update(step: next_step) if wizard_steps.index(@order.step.to_sym) <= wizard_steps.index(step)
  end

  def order
    @order = Order.find(session[:order_id]).decorate
  end
end