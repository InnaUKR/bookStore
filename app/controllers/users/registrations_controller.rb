class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: :cancel
  def new
    super
  end

  def update
    super
  end

  def create
    @user = guest_user
    @user.update(user_params)
    if @user.save
      @user.guest = false
      sign_up('user', @user)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end