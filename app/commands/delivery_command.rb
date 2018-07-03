class DeliveryCommand < Rectify::Command
  attr_reader :form

  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if form.invalid?
    broadcast(:ok)
  end
end