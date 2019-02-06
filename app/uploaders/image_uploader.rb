# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  storage :fog
end
