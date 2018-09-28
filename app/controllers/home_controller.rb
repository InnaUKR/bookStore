class HomeController < ApplicationController
  skip_authorization_check only: [:index]
  def index
    @latest_books = BookDecorator.decorate_collection(Book.latest_books.first(3))
    @best_sellers = BookDecorator.decorate_collection(Book.best_sellers.first(4))
  end
end
