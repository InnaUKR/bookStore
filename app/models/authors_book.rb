# frozen_string_literal: true

class AuthorsBook < ApplicationRecord
  belongs_to :book
  belongs_to :author
end
