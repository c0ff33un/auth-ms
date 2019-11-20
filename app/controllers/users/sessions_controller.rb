# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    if params[:user]
      email = params[:user][:email]
      password = params[:user][:password]
      
      base = 'ou=taurus, dc=taurus, dc=io'
      ldap = Net::LDAP.new
      ldap.host = 'localhost'
      ldap.port = 389
      ldap.auth "cn=#{email}, #{base}", "#{password}"
      
      bound = ldap.bind
      if bound
        ldap.search(base: base, filter: Net::LDAP::Filter.eq('cn', email)) do |entry|
          puts entry.dn
          entry.each do |attribute, values|
            puts "   #{attribute}"
            values.each do |value|
              puts"   ---->#{value}"
            end
          end
        end
        puts('TESTING 01')
        User.find_or_create_by(email: email) do |user|
          user.password = password
          user.confirm #this is hardcoded, just a test
        end
      else
        super
      end
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
