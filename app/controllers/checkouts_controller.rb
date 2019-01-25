class CheckoutsController < ApplicationController
  include Wicked::Wizard
  include Rectify::ControllerHelpers
  steps :address, :delivery, :payment, :confirm, :complete
  before_action :form, only: :update
  before_action :order, only: [:index, :update, :show, :edit]
  skip_authorization_check

  def show
    @form = "#{step.capitalize}Form".constantize.new
    address_form if step == :address
    payment_form if step == :payment
    render_wizard
  end

  def update
    if @form.valid?
      @form.update!(@order)
      set_order_step
      redirect_to wizard_path(@order.step)
    else
      render step
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

  def address_form(addresses_params = {})
    if @order.billing_address
      addresses_params[:billing_address_form] = @order.billing_address.attributes
    elsif current_user.addresses.where(billing: true).any?
      addresses_params[:billing_address_form] = current_user.addresses.where(billing: true).last.attributes
    end
    if @order.shipping_address
      addresses_params[:shipping_address_form] = @order.shipping_address.attributes
    elsif current_user.addresses.where(shipping: true).any?
      addresses_params[:shipping_address_form] = current_user.addresses.where(shipping: true).last.attributes
    end
      @form = "#{step.capitalize}Form".constantize.new(addresses_params)
    end

  def payment_form
    if @order.credit_card
      @form = @order.credit_card
    elsif current_user.credit_cards.any?
      @form = current_user.credit_cards.last
    end
    @form
  end

  def order
    @order = Order.find(session[:order_id]).decorate
  end
end