require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :delivery }
  it { is_expected.to validate_numericality_of(:total_price).is_greater_than_or_equal_to(0.01) }
  it { is_expected.to validate_presence_of :state }
end
