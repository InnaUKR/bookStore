class BookDecorator < Draper::Decorator
  delegate_all

  def dimensions
    "H:#{object.height}\" x W:#{width}\" x D:#{depth}"
  end

end
