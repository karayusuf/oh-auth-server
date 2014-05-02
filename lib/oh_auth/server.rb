require 'galago/router'
require_relative 'endpoints/authenticate_user'

module OhAuth
  class Server

    def self.router
      @router ||= Galago::Router.new do
        post 'token', to: Endpoints::AuthenticateUser
      end
    end

    def self.call(env)
      router.call(env)
    end

  end
end
