class BookDecorator < Draper::Decorator
  delegate_all

  def dimensions
    "H:#{height}\" x W:#{width}\" x D:#{depth}"
  end

  def year_of_publication
    date_of_publication.strftime('%Y')
  end

  def authors_to_string
    authors.each(&:to_s).join(', ')
  end

end
