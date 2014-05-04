require 'spec_helper'
require 'oh_auth/server'

module OhAuth
  module Endpoints
    describe AccessTokenValidator do
      let(:app) { OhAuth::Server }

      context "when the access token exists" do
        it "returns 204" do
          token = AccessToken.generate
          post '/validate_token', access_token: token

          expect(last_response.status).to eql 204
        end

        it "has no content" do
          token = AccessToken.generate
          post '/validate_token', access_token: token

          expect(last_response.body).to eql ''
        end
      end

      context "when the token does not exist" do
        it "returns 401" do
          post '/validate_token', access_token: 'fefe'

          expect(last_response.status).to eql 401
        end

        it "provides an error message" do
          post '/validate_token', access_token: 'fefe'

          response = JSON(last_response.body)
          expect(response['error']).to eql 'invalid token'
        end
      end

    end
  end
end

