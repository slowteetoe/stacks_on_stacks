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
	      if username == 'foo' && password == 'bar'
	        user = User.where(username: username.downcase).first_or_create
	        success! user
	      else
	        fail! "Sorry, your username or password is incorrect"
	      end
	    end

      private

			def username
			  (params[:user] || {})[:username]
			end

			def password
			  (params[:user] || {})[:password]
			end
    end 
  end 
end

Warden::Strategies.add(:kerberos_authenticatable, Devise::Strategies::KerberosAuthenticatable)
