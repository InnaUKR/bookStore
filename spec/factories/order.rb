FactoryBot.define do
  factory :order, class: Order do
    user_id { FactoryBot.create(:user).id }
  end
end