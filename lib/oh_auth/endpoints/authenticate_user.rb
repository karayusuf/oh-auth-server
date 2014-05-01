require 'rack'
require 'json'
require 'oh_auth/user'

module OhAuth
  module Endpoints
    class AuthenticateUser

      def self.call(env)
        Rack::Response.new(body)
      end

      def self.body
        JSON({
          "access_token"      => "2YotnFZFEjr1zCsicMWpAA",
          "token_type"        => "example",
          "expires_in"        => 3600,
          "refresh_token"     => "tGzv3JOkF0XG5Qx2TlKWIA",
          "example_parameter" => "example_value"
        })
      end

    end
  end
end
