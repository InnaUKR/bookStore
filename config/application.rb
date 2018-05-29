require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookstore
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.enforce_available_locales = true
    config.i18n.available_locales = [:en, :ru]
    config.i18n.default_locale = :en
    #config.force_ssl = true.
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       helpers_specs: false,
                       routing_specs: false,
                       controller_spec: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
