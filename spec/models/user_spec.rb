require 'rails_helper'

RSpec.describe User, :type => :model do
  context 'email' do
    it { is_expected.to validate_presence_of(:email)}

    it 'localpart is not empty(The localpart on the left of an @)' do
      user = User.new(email: '@gmail.com')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format of email')
    end

    it 'domain is not empty(The domain on the right of an @)' do
      user = User.new(email: 'testUser@')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format of email')
    end

    it 'is neither the localpart nor the domain can be empty' do
      user = User.new(email: '@')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format of email')
    end

    it 'is separated by dots' do
      user = User.new(email: 'test.test@test.test')
      user.valid?
      expect(user.errors[:email]).to be_empty
    end

    it 'is not have two successive dots' do
      user = User.new(email: 'test..test@test..test')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format of email')
    end

    it 'is not start with a dot' do
      user = User.new(email: '.test.test@test.test')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format of email')
    end

    it 'is not end with a dot.' do
      user = User.new(email: 'test.test@test.test.')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format of email')
    end

    it 'labels consist of a-z, A-Z, 0-9, or one of !#$%&\'*+-/=?^_`{|}~.' do
      user = User.new(email: 't-est1.2te-st.test@gmail.com')
      user.valid?
      expect(user.errors[:email]).to be_empty
    end

    it 'labels is not start with a hyphen' do
      user = User.new(email: '-test.-test@-gmail.com')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format of email')
    end

    it 'labels is not end with a hyphen' do
      user = User.new(email: 'test-.test-@gmail-.com')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format of email')
    end

    it 'contain two successive hyphens' do
      user = User.new(email: 'test--test@gmail.com')
      user.valid?
      expect(user.errors[:email]).to include('incorrect format of email')
    end
    context 'right-most label' do
      it 'is alphabetic'do
        user = User.new(email: 'test.test@gmail.com')
        user.valid?
        expect(user.errors[:email]).to be_empty
      end
      it 'is not digit'do
        user = User.new(email: 'test.test@gmail.4com')
        user.valid?
        expect(user.errors[:email]).to include('incorrect format of email')
      end
      it 'is not consist one of !#$%&\'*+-/=?^_`{|}~.' do
        user = User.new(email: 'test.test@gmail.c&m')
        user.valid?
        expect(user.errors[:email]).to include('incorrect format of email')
      end
    end
  end
  it { is_expected.to validate_presence_of(:password) }
end
