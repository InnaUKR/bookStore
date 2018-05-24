require 'rails_helper'

RSpec.describe Address, type: :model do
  it { is_expected.to validate_presence_of :address }
  it { is_expected.to validate_numericality_of(:address).is_less_than(50) }

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_numericality_of(:first_name).is_less_than(50) }

  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_numericality_of(:last_name).is_less_than(50) }

  it { is_expected.to validate_presence_of :city }
  it { is_expected.to validate_numericality_of(:city).is_less_than(50) }

  it { is_expected.to validate_presence_of :country }
  it { is_expected.to validate_numericality_of(:country).is_less_than(50) }

  it { is_expected.to validate_presence_of :zip }
  it { is_expected.to validate_length_of(:zip).is_at_most(10) }

  it { is_expected.to validate_presence_of :phone }
  it { is_expected.to validate_numericality_of(:phone).is_less_than_or_equal_to(15) }
end