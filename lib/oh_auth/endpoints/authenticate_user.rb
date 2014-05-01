require 'rack'
require 'json'
require 'oh_auth/user'

module OhAuth
  module Endpoints
    class AuthenticateUser

      def self.call(env)
        request = Rack::Request.new(env)
        user    = User.find(request.params['username'])

        if user && user.authenticate?(request.params['password'])
          render_json(success, 200)
        else
          render_json(error, 401)
        end
      end

      private

      def self.render_json(body, status_code)
        Rack::Response.new(body, status_code, {
          'Content-Type' => 'application/json'
        })
      end

      def self.success
        JSON({
          "access_token"      => "2YotnFZFEjr1zCsicMWpAA",
          "token_type"        => "example",
          "expires_in"        => 3600,
          "refresh_token"     => "tGzv3JOkF0XG5Qx2TlKWIA",
        })
      end

      def self.error
        JSON({ "error" => "invalid username or password" })
      end

    end
  end
end

