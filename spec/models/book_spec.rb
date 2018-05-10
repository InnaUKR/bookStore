require 'rails_helper'
require 'faker'

RSpec.describe Book, :type => :model do
  it { is_expected.to have_and_belong_to_many(:authors) }
  it { is_expected.to have_many(:line_items) }
  it { is_expected.to belong_to(:category).counter_cache }

  it { is_expected.to validate_presence_of(:title) }
  #it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  it { is_expected.to validate_presence_of(:date_of_publication) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }
  it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:width).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:depth).is_greater_than(0) }
end


