# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[index]
  before_action :set_filter, only: %i[index]

  authorize_resource

  def index
    @categories = Category.all
    @books = @category.nil? ? Book.filter(@filter).decorate : Book.filter_category(@category, @filter).decorate
  end

  private

  def set_category
    @category = params[:category]
  end

  def set_filter
    @filter = Book::FILTERS.key?(params[:filter]&.to_sym) ? params[:filter] : Book::DEFAULT_FILTER
  end
end
