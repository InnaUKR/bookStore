class DeliveryForm < Rectify::Form
  attribute :delivery_id, Integer
  validates :delivery_id, presence: true
end