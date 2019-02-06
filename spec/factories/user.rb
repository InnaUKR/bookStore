# frozen_string_literal: true

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
    sequence(:email) { |n| "user#{n}@test.com" }
    password 'AdminNo1'
    password_confirmation 'AdminNo1'
    admin true
  end
end
