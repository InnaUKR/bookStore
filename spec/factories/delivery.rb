FactoryBot.define do
  factory :delivery, class: Delivery do
    method_name 'method name'
    days  { Faker::Number.digit }
    price { Faker::Commerce.price }
  end
end