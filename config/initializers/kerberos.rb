require 'devise/strategies/authenticatable'
require 'krb5_auth'
include Krb5Auth


module Devise
  module Strategies
    class KerberosAuthenticatable < Authenticatable

      def valid?
	      username && password
	    end
 
	    def authenticate!
        logger.info "Attempting to auth using Kerberos"
        krb5 = Krb5.new
        begin
          krb5.get_init_creds_password(username, password)
          logger.info "User/pass authenticated successfully."
          user = User.where(username: username).first_or_create
          logger.info user
          success! user
        rescue Krb5Auth::Krb5::Exception
          logger.info "User/pass failed!"
          fail! "Sorry, your username or password is incorrect (krb err:#{$!})"
        end
	    end

    private

			def username
			  (params[:user] || {})[:username]
			end

			def password
			  (params[:user] || {})[:password]
			end

      def logger
        @logger ||= Logger.new(STDOUT)
      end

    end 
  end 
end

Warden::Strategies.add(:kerberos_authenticatable, Devise::Strategies::KerberosAuthenticatable)
