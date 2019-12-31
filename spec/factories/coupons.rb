# frozen_string_literal: true

FactoryBot.define do
  factory :coupon, class: Coupon do
    name { 'coupon name' }
    amount { 1 }
  end
end
