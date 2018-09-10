FactoryBot.define do
  factory :review do
    title { 'MyText' }
    text { 'Text about book' }
    score { 5 }
    user { create(:user) }
    book { create(:book) }
    state { 'unprocessed' }

    trait :approved do
      state { 'approved' }
    end

    trait :rejected do
      state { 'rejected' }
    end
  end
end
