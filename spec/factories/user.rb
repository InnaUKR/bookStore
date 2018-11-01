FactoryBot.define do

  factory :user, class: User do
    sequence(:email) { |n| "user#{n}@test.com" }
    password { 'password1A' }
    password_confirmation { password }
    guest { false }
    trait :guest do
      guest { true }
    end
    admin { false }
  end

  factory :admin, class: User do
    email
    password '12345678'
    password_confirmation '12345678'
    admin true
  end
end