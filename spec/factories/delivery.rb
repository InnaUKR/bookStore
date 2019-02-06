# frozen_string_literal: true

FactoryBot.define do
  factory :delivery, class: Delivery do
    method_name 'method name'
    days  { Faker::Number.digit }
    price { 5 }
  end
end
