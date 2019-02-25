# frozen_string_literal: true

class User < ApplicationRecord
  CHARACTERS = "\\-!#\\$%&'\\*\\+\\/=\\?\\^_`{|}~"
  LABEL = "(?!-)(\\w+(?!-\\.)[#{CHARACTERS}]?){1,62}"
  DOT_LABELS = "(\\.(?!-)(\\w+(?!-\\.)(?!-\\@)[#{CHARACTERS}]?){1,62})*"
  RIGHT_MOST_LABEL = '\\.([a-z+]){1,62}'
  VALID_EMAIL_REGEX = /\A#{LABEL}#{DOT_LABELS}@#{LABEL}#{DOT_LABELS}#{RIGHT_MOST_LABEL}\z/i
  VALID_PASSWORD_REGEXP = /\A(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[a-zA-Z\d]{8,}\z/

  has_many :reviews, dependent: :destroy
  has_many :orders
  has_many :credit_cards, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_one :image, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :image
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :password,
            format: { with: VALID_PASSWORD_REGEXP,
                      message: I18n.t('errors.messages.password') },
            confirmation: true,
            presence: true, if: :password_required?
  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX,
                      message: I18n.t('errors.messages.email') }

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20] until user.valid?
      user.name = auth.info.name

      user.image = Image.new(remote_image_url: auth.info.image) if auth.info.image?
    end
  end
end
