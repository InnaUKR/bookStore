FactoryBot.define do
  factory :book, class: Book do
    title { Faker::Book.title }
    price { Faker::Commerce.price }
    description { '' }
    date_of_publication Date.today
    material { Faker::Commerce.material }
    height { Faker::Number.between(0.00, 10.00) }
    width { Faker::Number.between(0.00, 10.00) }
    depth { Faker::Number.between(0.00, 10.00) }
    category_id { FactoryBot.create(:category).id }

  end
end