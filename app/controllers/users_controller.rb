class UsersController < ApplicationController
  before_action :set_user
  authorize_resource

  def edit
    update_password unless new_password_params.empty?
    @billing_address = current_address(:billing)
    @shipping_address = current_address(:shipping)
    @email = email
  end

  private

  def update_password
    if @user.valid_password?(current_password_params[:current_password])
      if @user.update_attributes(new_password_params)
        bypass_sign_in(@user)
        flash[:notice] = "Password updated"
        params[:user].except(:password, :password_confirmation, :current_password)
      end
    else
      flash[:alert] = "Password not updated"
      @user.errors[:current_password] << "Incorrect password"
    end
  end

  def set_user
    @user = current_user
  end

  def current_address(type)
    if params_contain?(type)
      address_by(send("#{type}_params"))
    else
      @user.addresses.where("#{type} IS true").order(:updated_at).last || current_user.addresses.build
    end
  end

  def address_by(address_params)
    @user.addresses.exists?(address_params) ? @user.addresses.find(address_params).touch : create_address(address_params)
  end

  def create_address(address_params)
    address = AddressFieldsForm.new(address_params)
    address.valid? ? @user.addresses.create(address_params) : address
  end

  def email
    @user.update(email: params[:email]) if params.key?(:email)
    @user.email
  end

  def params_contain?(type)
    !params.nil? && params.key?('address') && params[:address].key?("#{type}_address_form")
  end

  def billing_params
    params.require(:address).require(:billing_address_form).permit(:first_name, :last_name, :country, :address,
                                                                   :city, :zip, :phone).to_h.merge!(billing: true)
  end

  def shipping_params
    params.require(:address).require(:shipping_address_form).permit(:first_name, :last_name, :country, :address,
                                                                    :city, :zip, :phone).to_h.merge!(shipping: true)
  end

  def current_password_params
    params.require(:user).permit(:current_password)
  end

  def new_password_params
    params.require(:user).permit(:password, :password_confirmation)
  rescue ActionController::ParameterMissing
    {}
  end
end