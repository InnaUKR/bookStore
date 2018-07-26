FactoryBot.define do
  factory :order, class: Order do
    user_id { FactoryBot.create(:user).id }
    delivery_id { FactoryBot.create(:delivery).id }
    total_price { Faker::Commerce.price }
  end
end