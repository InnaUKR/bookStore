# frozen_string_literal: true

FactoryBot.define do
  factory :credit_card, class: CreditCard do
    number { '12345678' }
    cvv { '123' }
    card_name { 'My card' }
    exp_date { '11/28' }
    user
  end
end
