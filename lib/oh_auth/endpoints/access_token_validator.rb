require 'rack'
require 'json'

require_relative '../../oh_auth/models/token'

module OhAuth
  module Endpoints
    class AccessTokenValidator

      def self.call(env)
        request = Rack::Request.new(env)

        if AccessToken.exists?(request.params['access_token'])
          Rack::Response.new('', 204)
        else
          render_json({'error' => 'invalid token' }, 401)
        end
      end

      private

      def self.render_json(body, status_code)
        Rack::Response.new(JSON(body), status_code, {
          'Content-Type' => 'application/json'
        })
      end

    end
  end
end

