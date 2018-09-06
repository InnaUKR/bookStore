require 'rails_helper'

RSpec.describe PaymentForm, type: :model do
  it { is_expected.to validate_presence_of(:number) }
  it 'Card Number can start with ' do
    payment = PaymentForm.new(number: ' 123456789')
    payment.valid?
    expect(payment.errors[:number]).to be_empty
  end

  it { is_expected.to validate_presence_of(:card_name) }
  it { is_expected.to validate_length_of(:card_name).is_at_most(50) }
  it 'card name can consist of English letters and spaces' do
    payment = PaymentForm.new(card_name: 'card name')
    payment.valid?
    expect(payment.errors[:card_name]).to be_empty
  end
  it 'card name can not consist numbers' do
    payment = PaymentForm.new(card_name: 'card 01')
    payment.valid?
    expect(payment.errors[:card_name]).to include('can consist of English letters and spaces')
  end

  it { is_expected.to validate_presence_of(:exp_date) }
  context 'MM/YY' do
    it 'month value can be from 01 to 12' do
      payment = PaymentForm.new(exp_date: '03/26')
      payment.valid?
      expect(payment.errors[:exp_date]).to be_empty
    end
    it 'month value can not be one digit' do
      payment = PaymentForm.new(exp_date: '3/26')
      payment.valid?
      expect(payment.errors[:exp_date]).to include('month value can not be one digit')
    end
  end

  it { is_expected.to validate_presence_of(:cvv) }
  it { is_expected.to validate_length_of(:cvv).is_at_least(3).is_at_most(4) }

end