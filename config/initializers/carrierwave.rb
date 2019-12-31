# frozen_string_literal: true

CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'

  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     ENV['GOOGLE_STORAGE_ACCESS_KEY_ID'], # ENV['GOOGLE_STORAGE_SECRET_ACCESS_KEY'],
    google_storage_secret_access_key: ENV['GOOGLE_STORAGE_SECRET_ACCESS_KEY'] # ENV['GOOGLE_STORAGE_ACCESS_KEY_ID']
  }
  config.fog_directory = 'bookstore-image'
end
