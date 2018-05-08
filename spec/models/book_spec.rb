require 'rails_helper'
require 'faker'

RSpec.describe Book, :type => :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:date_of_publication) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }
  it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:width).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:depth).is_greater_than(0) }
end


