FactoryBot.define do
  factory :address, class: Address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    zip { '123456789' }
    country 'USA'
    phone { '+380965061024' }
  end
end