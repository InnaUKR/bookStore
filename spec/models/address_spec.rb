require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to have_many(:orders) }
  it { is_expected.to have_one(:user) }
  it { is_expected.to validate_presence_of :address }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :city }
  it { is_expected.to validate_presence_of :country }
  it { is_expected.to validate_presence_of :zip }
  it { is_expected.to validate_presence_of :phone }
end