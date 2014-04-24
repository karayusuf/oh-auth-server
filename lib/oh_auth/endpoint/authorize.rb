require 'rack'

module OhAuth
  module Endpoint

    class Authorize

      REQUIRED_PARAMS = ['response_type', 'client_id']

      def self.call(env)
        new(env).response
      end

      def initialize(request)
        @request = Rack::Request.new(request)
      end

      def response
        if valid_request?
          Rack::Response.new('bar').finish
        else
          Rack::Response.new('invalid').finish
        end
      end

      def valid_request?
        REQUIRED_PARAMS.all? { |param| @request.params.has_key?(param) }
      end
    end

  end
end
