FactoryBot.define do
  factory :review do
    body "MyText"
    book ""
    mark 1
  end

  factory :invalid_review, class: 'Review' do
    body nil
  end
end
