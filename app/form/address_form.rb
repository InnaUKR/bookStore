class AddressForm < CheckoutForm
  attr_accessor :billing_address, :shipping_address
  attribute :use_billing, Boolean, default: 'false'

  def initialize(params = nil)
    if params
      if params[:use_billing] == 'true'
        address_params = billing_params(params)
        @billing_address = AddressFieldsForm.from_params(address_params)
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

    order.update(billing_address_id: billing.id, shipping_address_id: shipping.id)
  end
  private

  def billing_params(params)
    params[:billing_address_form]
  end

  def shipping_params(params)
    params[:shipping_address_form]
  end

  def address(order, address)
    if Address.find_by(address.attributes)
      order.user.addresses.find_by(address.attributes)
    else
      order.user.addresses.create(address.attributes)
    end
  end

end