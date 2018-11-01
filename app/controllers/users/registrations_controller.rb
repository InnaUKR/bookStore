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

  def create
    @user = guest_user
    @user.update(user_params)
    @user.guest = false
    if @user.save
      sign_up('user', @user)
      redirect_to root_path
    else
      render :new
    end
  end

  def self.create_from_omniauth(params)
    user = find_or_create_by(email: params.info.email, uid: params.uid)
    user.update({
                    token: params.credentials.token,
                    name: params.info.name,
                    avatar: params.info.image
                })
    user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end