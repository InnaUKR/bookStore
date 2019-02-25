# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: :cancel

  def new
    super
  end

  def delete
    super if params[:delete_account] == 'true'
  end

  def update
    super
  end

  def edit
    super
  end

  def create
    build_resource(sign_up_params)
    resource.save
    if resource.persisted?
      sign_up('user', @user)
      redirect_to root_path
    else
      set_minimum_password_length
      resource.errors.full_messages.each {|x| flash[x] = x}
      render :'devise/registrations/new'
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
    params.require(:user).permit(:email, :password).merge(guest: false)
  end
end
