class ReviewDecorator < Draper::Decorator
  STARS_MAX_SCORE = 5
  delegate_all
  def blank_stars
    STARS_MAX_SCORE - score
  end
  def data_to_str
    created_at.to_time.strftime('%d/%m/%y')
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
