class User < ApplicationRecord
  CHARACTERS = "\\-!#\\$%&'\\*\\+\\/=\\?\\^_`{|}~"
  LABEL = "(?!-)(\\w+(?!-\\.)[#{CHARACTERS}]?){1,62}"
  DOT_LABELS = "(\\.(?!-)(\\w+(?!-\\.)(?!-\\@)[#{CHARACTERS}]?){1,62})*"
  RIGHT_MOST_LABEL = "\\.([a-z+]){1,62}"
  VALID_EMAIL_REGEX = /\A#{LABEL}#{DOT_LABELS}@#{LABEL}#{DOT_LABELS}#{RIGHT_MOST_LABEL}\z/i
  VALID_PASSWORD_REGEXP = /\A(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[a-zA-Z\d]{8,}\z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_one :cart
  has_many :reviews
  has_many :orders
  has_many :credit_cards
  has_many :addresses
  has_one :image, as: :imageable
  accepts_nested_attributes_for :image

  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX,
                      message: 'incorrect format of email' }
  validates :password,
            format: { with: VALID_PASSWORD_REGEXP,
                      message: 'should contain at least 1 uppercase, 1 lowercase and 1 number' },
            confirmation: true,
            presence: true, if: :password_required?

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      #user.image = auth.info.image
    end
  end

end
