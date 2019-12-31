# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorsBook, type: :model do
  it { is_expected.to belong_to :book }
  it { is_expected.to belong_to :author }
end
