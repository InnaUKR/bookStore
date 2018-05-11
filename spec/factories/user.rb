FactoryBot.define do
  sequence :email do |n|
    'user#{n}@test.com'
  end

  factory :user, class: User do
    email
    password '12345678'#{ Faker::Internet.password(8) }
    password_confirmation '12345678'
    guest false
    admin false
  end

  factory :admin, class: User do
    email
    password '12345678'#{ Faker::Internet.password(8) }
    password_confirmation '12345678'
    admin true
  end
end