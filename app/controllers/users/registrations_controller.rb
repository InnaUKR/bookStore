# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: :cancel
  before_action :sign_up_params, only: :create

  def new
    super
  end

  def destroy
    redirect_back(fallback_location: root_path) if params[:delete_account] != 'true'
    super
    session.delete(:guest_user_id)
  end

  def update
    super
  end

  def edit
    super
  end

  def create
    @user = current_user
    @user.attributes = @sign_up_params
    if @user.save
      sign_up('user', @user)
      redirect_to root_path
    else
      render 'devise/registrations/new'
    end
  end

  def self.create_from_omniauth(params)
    user = find_or_create_by(email: params.info.email, uid: params.uid)
    user.update(
      token: params.credentials.token,
      name: params.info.name,
      avatar: params.info.image
    )
    user
  end

  private

  def sign_up_params
    @sign_up_params = params.require(:user).permit(:email, :password).merge(guest: false)
  end
end
