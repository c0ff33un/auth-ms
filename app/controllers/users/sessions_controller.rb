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

      ldap = adminLdap()
      
      if ldap.bind
        print("USING LDAP")
        uid = nil
        ldap.search(base: base, filter: Net::LDAP::Filter.eq("cn", email),
          attributes: ['uid', 'objectclass']){ |ldap|
            uid = ldap.uid.first   
        }
        auth = ldap.authenticate "cn=#{email}, #{base}", password
        if uid && auth
          User.find_or_create_by(email: email) do |user|
            user.handle = uid
            user.password = password
            user.confirm
          end
        end
      else
        print("USING DATABASE DIRECTLY")
      end
    end
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected
    def adminLdap
      ldap = Net::LDAP.new
      ldap.host = ENV['LDAP_HOST']
      ldap.port = ENV['LDAP_PORT']
      ldap.auth "cn=#{ENV['LDAP_ADMIN']}, dc=taurus, dc=io", ENV['LDAP_ADMIN_PASSWORD']
      
      return ldap
    end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
