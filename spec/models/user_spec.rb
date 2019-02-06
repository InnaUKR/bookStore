# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_many(:credit_cards) }
  it { is_expected.to have_many(:addresses) }
  it { is_expected.to have_one(:image) }

  context 'email' do
    it { is_expected.to validate_presence_of(:email) }

    it 'localpart is not empty(The localpart on the left of an @)' do
      user = User.new(email: '@gmail.com')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format')
    end

    it 'domain is not empty(The domain on the right of an @)' do
      user = User.new(email: 'testUser@')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format')
    end

    it 'is neither the localpart nor the domain can be empty' do
      user = User.new(email: '@')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format')
    end

    it 'is separated by dots' do
      user = User.new(email: 'test.test@test.test')
      user.valid?
      expect(user.errors[:email]).to be_empty
    end

    it 'is not have two successive dots' do
      user = User.new(email: 'test..test@test..test')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format')
    end

    it 'is not start with a dot' do
      user = User.new(email: '.test.test@test.test')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format')
    end

    it 'is not end with a dot.' do
      user = User.new(email: 'test.test@test.test.')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format')
    end

    it 'labels consist of a-z, A-Z, 0-9, or one of !#$%&\'*+-/=?^_`{|}~.' do
      user = User.new(email: 't-est1.2te-st.test@gmail.com')
      user.valid?
      expect(user.errors[:email]).to be_empty
    end

    it 'labels is not start with a hyphen' do
      user = User.new(email: '-test.-test@-gmail.com')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format')
    end

    it 'labels is not end with a hyphen' do
      user = User.new(email: 'test-.test-@gmail-.com')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format')
    end

    it 'contain two successive hyphens' do
      user = User.new(email: 'test--test@gmail.com')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format')
    end

    context 'right-most label' do
      it 'is alphabetic' do
        user = User.new(email: 'test.test@gmail.com')
        user.valid?
        expect(user.errors[:email]).to be_empty
      end

      it 'is not digit' do
        user = User.new(email: 'test.test@gmail.4com')
        user.valid?
        expect(user.errors[:email]).to include('incorrect format')
      end

      it 'does not consist one of !#$%&\'*+-/=?^_`{|}~.' do
        user = User.new(email: 'test.test@gmail.c&m')
        user.valid?
        expect(user.errors[:email]).to include('incorrect format')
      end
    end
  end

  context 'password' do
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }

    it 'contains uppercase letters, lowercase letters and numbers' do
      user = User.new(password: 'PAsswoRD1234')
      user.valid?
      expect(user.errors[:password]).to be_empty
    end

    it 'does not contain uppercase letters' do
      user = User.new(password: 'password1234')
      user.valid?
      expect(user.errors[:password]).to include('should contain at least 1 uppercase, 1 lowercase and 1 number')
    end

    it 'does not contain lowercase letters' do
      user = User.new(password: 'PASSWORD1234')
      user.valid?
      expect(user.errors[:password]).to include('should contain at least 1 uppercase, 1 lowercase and 1 number')
    end

    it 'does not contain numbers' do
      user = User.new(password: 'PAsswoRD')
      user.valid?
      expect(user.errors[:password]).to include('should contain at least 1 uppercase, 1 lowercase and 1 number')
    end

    it 'mustn’t contain spaces inside' do
      user = User.new(password: 'PAsswoRD 1234')
      user.valid?
      expect(user.errors[:password]).to include('should contain at least 1 uppercase, 1 lowercase and 1 number')
    end
  end
end
