FactoryBot.define do
  factory :orders, class: Order do
    user_id { FactoryBot.create(:user).id }
    delivery_id { FactoryBot.create(:delivery).id }
    state
    total_price { Faker::Commerce.price }
  end
end