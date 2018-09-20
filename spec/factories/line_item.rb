FactoryBot.define do
  factory :line_item, class: LineItem do
    quantity { 1 }
    book
    order
  end
end
