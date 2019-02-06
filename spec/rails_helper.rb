# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'cancan/ability'
require 'support/factory_bot'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Devise::Test::IntegrationHelpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include FeatureHelper, type: :feature
  config.use_transactional_fixtures = false
  config.filter_rails_from_backtrace!
end
