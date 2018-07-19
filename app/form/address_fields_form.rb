class AddressFieldsForm < Rectify::Form
  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, String
  attribute :country, String
  attribute :phone, String

  validates :address, :first_name, :last_name, :city, :country, :zip, :phone,
            presence: true
  validates :address, :first_name, :last_name, :city, :country,
            length: { maximum: 50 }
  validates :first_name, :last_name, :city, :country,
            format: { with: /\A[a-zA-Zа-яА-Я]+\z/ }
  validates :address,
            format: { with: /\A[a-zA-Zа-яА-Я0-9\s,-]+\z/ }
  validates :zip,
            format: { with: /\A[0-9]+\z/ },
            length: { maximum: 10 }
  validates :phone,
            format: { with: /\A\+[\d]{3}[0-9]+\z/ },
            length: { maximum: 15 }
end