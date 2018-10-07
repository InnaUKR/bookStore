FactoryBot.define do
  factory :order, class: Order do
    user
    coupon { nil }
    trait :with_coupon do
      coupon
    end
    trait :with_delivery do
      delivery
    end

    trait :address do
      step { 'address' }
    end
    trait :delivery do
      step { 'delivery' }
      association :shipping_address, factory: :address
      association :billing_address, factory: :address
    end
    trait :payment do
      step { 'payment' }
      association :shipping_address, factory: :address
      association :billing_address, factory: :address
      delivery
    end
    trait :confirm do
      step { 'confirm' }
      association :shipping_address, factory: :address
      association :billing_address, factory: :address
      delivery
      credit_card
    end
    trait :complete do
      step { 'complete' }
      association :shipping_address, factory: :address
      association :billing_address, factory: :address
      delivery
      credit_card
    end

  end
end