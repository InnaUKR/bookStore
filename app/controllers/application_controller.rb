class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_order
  before_action :set_locale

  check_authorization unless: :do_not_check_authorization?


  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def current_order
    id = session[:current_order_id] ? session[:current_order_id] : create_order
    Order.find(id)
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

  def create_order
    session[:current_order_id] = current_user.orders.create.id
  end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_back(fallback_location: root_path, alert: exception.message)
  end

  def do_not_check_authorization?
    :devise_controller? || :rails_admin_controller?
  end
end
