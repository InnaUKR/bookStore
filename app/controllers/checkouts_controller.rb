class CheckoutsController < ApplicationController
  include Wicked::Wizard
  #include Rectify::ControllerHelpers
  steps :delivery, :payment, :confirm, :complete

  def new
    @form = AddressForm.new
    render_wizard
  end

  def show
    @order = Order.new
    @deliveries = Delivery.all
    render_wizard
  end

  def update

  end

  def create
    render_wizard
    @order = Order.new
    @order_form = DeliveryForm.new
    @form = DeliveryForm.from_params(params)

    if @form.valid?
      render_wizard
    else
      redirect_to wizard_path(steps.first)
    end
    #redirect_to wizard_path(steps.first, :order_id => @order.id)
  end

end
