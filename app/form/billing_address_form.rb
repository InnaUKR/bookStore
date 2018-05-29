class BillingAddressForm < Rectify::Form
  attribute :addressable_type, String, default: 'billing'
end