# frozen_string_literal: true

class AddressForm < CheckoutForm
  attr_accessor :billing_address, :shipping_address
  attribute :use_billing, String, default: 'false'

  def initialize(params = {})
    if params.any?
      if params[:use_billing] == 'true'
        @billing_address = AddressFieldsForm.from_params(billing_and_shipping_params(params))
        @shipping_address = @billing_address
      else
        @billing_address = AddressFieldsForm.from_params(billing_params(params))
        @shipping_address = AddressFieldsForm.from_params(shipping_params(params))
      end
    else
      @billing_address = AddressFieldsForm.new
      @shipping_address = AddressFieldsForm.new
    end
    super
  end

  def valid?
    billing = @billing_address.valid?
    shipping = @shipping_address.valid?
    billing && shipping
  end

  def update!(order)
    billing = address(order, @billing_address)
    shipping = address(order, @shipping_address)

    order.update(billing_address: billing, shipping_address: shipping)
  end

  private

  def billing_params(params)
    params[:billing_address_form].to_h.merge!(billing: true)
  end

  def billing_and_shipping_params(params)
    params[:billing_address_form].to_h.merge!(billing: true, shipping: true)
  end

  def shipping_params(params)
    params[:shipping_address_form].to_h.merge!(shipping: true)
  end

  def address(order, address)
    if Address.find_by(address.attributes)
      Address.find_by(address.attributes)
    else
      order.user.addresses.create(address.attributes)
    end
  end
end
