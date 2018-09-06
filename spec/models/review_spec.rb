require 'rails_helper'

RSpec.describe Review, type: :model do
  it { is_expected.to belong_to :book }

  context 'title' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(80) }

    it 'consists of a-z, A-Z, 0-9, or one of !#$%&\'*+-/=?^_`{|}~.' do
      review = Review.new(title: '#cool #book!')
      review.valid?
      expect(review.errors[:title]).to be_empty
    end

    it 'consists irregular character' do
      review = Review.new(title: '(cool book)')
      review.valid?
      expect(review.errors[:title]).to include('is invalid')
    end

  end

  context 'text' do
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_length_of(:text).is_at_most(500) }

    it 'consists of a-z, A-Z, 0-9, or one of !#$%&\'*+-/=?^_`{|}~.' do
      review = Review.new(text: 'I am not suggesting that')
      review.valid?
      expect(review.errors[:text]).to be_empty
    end

    it 'consists irregular character' do
      review = Review.new(text: ' I am not suggesting that:)')
      review.valid?
      expect(review.errors[:text]).to include('is invalid')
    end
  end


end
