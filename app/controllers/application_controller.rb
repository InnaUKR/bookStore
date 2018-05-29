class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_cart
  before_action :set_locale

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def current_cart
    current_user.cart || current_user.create_cart
  end

  def current_user
    super || guest_user
  end

  private

  def guest_user
    User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  end

  def create_guest_user
    user = User.new { |user| user.guest = true }
    user.email = "guest_#{Time.now.to_i}#{rand(99)}@guest.com"
    user.save(validate: false)
    user
  end
end
