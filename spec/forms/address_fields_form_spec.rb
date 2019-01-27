require 'rails_helper'

RSpec.describe AddressFieldsForm, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_length_of(:first_name).is_at_most(50) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:last_name).is_at_most(50) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_length_of(:address).is_at_most(50) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_length_of(:country).is_at_most(50) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_length_of(:city).is_at_most(50) }
  it { is_expected.to validate_presence_of(:zip) }
  it { is_expected.to validate_length_of(:zip).is_at_most(10) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_length_of(:phone).is_at_most(15) }

  context 'first_name, last_name, city and country' do
    it 'consist of only a-z and A-Z characters' do
      address = AddressFieldsForm.new(first_name: 'Ann', last_name: 'Doe',
                                      city: 'Dnipro', country: 'Ukraine')
      address.valid?
      expect(address.errors[:first_name]).to be_empty
      expect(address.errors[:last_name]).to be_empty
      expect(address.errors[:city]).to be_empty
      expect(address.errors[:country]).to be_empty
    end

    it 'do not consist special symbols' do
      address = AddressFieldsForm.new(first_name: 'Ann (#awesome!)', last_name: 'Doe1',
                                      city: 'New-York', country: '@1USA')
      address.valid?
      expect(address.errors[:first_name]).to include('is invalid')
      expect(address.errors[:last_name]).to include('is invalid')
      expect(address.errors[:city]).to include('is invalid')
      expect(address.errors[:country]).to include('is invalid')
    end
  end

  context 'address' do
    it 'consist of a-z, A-Z, 0-9,’,’, ‘-’, ‘ ’ only' do
      address = AddressFieldsForm.new(address: '30, Commercial-Road')
      address.valid?
      expect(address.errors[:address]).to be_empty
    end

    it 'does not consist special symbols' do
      address = AddressFieldsForm.new(address: '30, Commercial&Road')
      address.valid?
      expect(address.errors[:address]).to include('is invalid')
    end
  end

  context 'zip' do
    it 'consists of 0-9 only' do
      address = AddressFieldsForm.new(zip: '7206')
      address.valid?
      expect(address.errors[:zip]).to be_empty
    end

    it 'consists of 0-9 only,’-’ no special symbols' do
      address = AddressFieldsForm.new(zip: '72-06')
      address.valid?
      expect(address.errors[:zip]).to include('should not contain any special symbols')
    end
  end

  context 'phone' do
    it 'consists of plus (+) at the beginning and 0-9 ' do
      address = AddressFieldsForm.new(phone: '+380505944123')
      address.valid?
      expect(address.errors[:phone]).to be_empty
    end

    it 'consists of plus (+) at the beginning and 0-9 only no special symbols' do
      address = AddressFieldsForm.new(phone: '+(380)-505944123')
      address.valid?
      expect(address.errors[:phone]).to include('should not contain special symbols')
    end
  end
end
