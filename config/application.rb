require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Bookstore
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.enforce_available_locales = true
    config.i18n.available_locales = [:en, :ru]
    config.i18n.default_locale = :en
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       helpers_specs: false,
                       routing_specs: false,
                       controller_spec: true
    end
  end
end
