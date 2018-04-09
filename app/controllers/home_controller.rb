class HomeController < ApplicationController
  def index
    @latest_books = Book.all.order('created_at').last(3).each(&:decorate)
    @best_sellers = Book.all.order('created_at').last(4).each(&:decorate)
  end
end
