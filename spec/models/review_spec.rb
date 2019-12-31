# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:book) { create(:book) }
  let(:unprocessed_review) { create(:review, book: book) }
  let(:approved_review) { create(:review, :approved, book: book) }
  let(:rejected_review) { create(:review, :rejected, book: book) }

  it { is_expected.to belong_to :book }
  it { is_expected.to belong_to :user }

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
  context '#approved_reviews' do
    it 'returns approved reviews' do
      expect(Review.approved_reviews(book)).to include(approved_review)
    end

    it 'does not return unapproved reviews' do
      create(:review, book: book)
      expect(Review.approved_reviews(book)).to_not include(unprocessed_review, rejected_review)
    end
  end

  context '#new_reviews' do
    it 'returns unprocessed reviews' do
      expect(Review.new_reviews).to include(unprocessed_review)
    end

    it 'does not return approved and rejected reviews' do
      expect(Review.new_reviews).to_not include(approved_review, rejected_review)
    end
  end

  context '#processed' do
    it 'returns approved and rejected reviews' do
      expect(Review.processed).to include(approved_review, rejected_review)
    end

    it 'does not return unprocessed reviews' do
      expect(Review.processed).to_not include(unprocessed_review)
    end
  end

  context 'status of review can be unprocessed, approved and rejected' do
    it { expect(unprocessed_review).to have_state(:unprocessed) }
    it { expect(unprocessed_review).to transition_from(:unprocessed).to(:approved).on_event(:approve) }
    it { expect(approved_review).to_not allow_transition_to(:unprocessed) }
    it { expect(unprocessed_review).to transition_from(:unprocessed).to(:rejected).on_event(:reject) }
    it { expect(rejected_review).to_not allow_transition_to(:unprocessed) }
  end
end
