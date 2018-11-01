FactoryBot.define do
  factory :coupon, class: Coupon do
    name { 'coupon name' }
    amount { 1 }
  end
end
