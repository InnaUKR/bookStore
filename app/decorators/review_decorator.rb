class ReviewDecorator < Draper::Decorator
  STARS_MAX_SCORE = 5
  delegate_all
  def blank_stars
    STARS_MAX_SCORE - score
  end
  def data_to_str
    created_at.to_time.strftime('%d/%m/%y')
  end

end
