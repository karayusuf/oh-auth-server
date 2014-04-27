require 'galago/router'
require_relative 'endpoint/authenticate_user'

module OhAuth
  class Server

    def self.router
      @router ||= Galago::Router.new do
        get 'auth', to: Endpoint::Authorize
      end
    end

    def self.call(env)
      router.call(env)
    end

  end
end
