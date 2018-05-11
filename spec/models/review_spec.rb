require 'rails_helper'

RSpec.describe Review, type: :model do
  it { is_expected.to belong_to :book }
  it { is_expected.to validate_presence_of :mark }
  it { is_expected.to validate_presence_of :body }
end
