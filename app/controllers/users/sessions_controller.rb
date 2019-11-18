# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
    # begin
    #   user = warden.authenticate!(:database_authenticatable)
    # rescue Exception => e
    #   user = warden.authenticate!(:ldap_authenticatable)
    # end
    # sign_in(resource_name, user)
    # yield user if block_given?
    # respond_with user, location: after_sign_in_path_for(user)
  end

  # DELETE /resource/sign_out
  def destroy
    
    user.destroy() 
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
