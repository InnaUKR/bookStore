class ShippingAddressForm < Rectify::Form
  attribute :addressable_type, String, default: 'shipping'
end