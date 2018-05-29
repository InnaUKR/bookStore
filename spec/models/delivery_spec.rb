require 'rails_helper'

RSpec.describe Delivery, type: :model do
  it { is_expected.to have_many(:orders) }
  it { is_expected.to validate_presence_of :method_name }
  it { is_expected.to validate_numericality_of(:days).presence }
  it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }
end