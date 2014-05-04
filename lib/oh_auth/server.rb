require 'galago/router'
require_relative 'endpoints/authenticate_user'
require_relative 'endpoints/access_token_validator'

module OhAuth
  class Server

    def self.router
      @router ||= Galago::Router.new do
        post 'token', to: Endpoints::AuthenticateUser
        post 'validate_token', to: Endpoints::AccessTokenValidator
      end
    end

    def self.call(env)
      router.call(env)
    end

  end
end
