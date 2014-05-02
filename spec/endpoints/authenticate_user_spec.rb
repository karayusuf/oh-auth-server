require 'spec_helper'
require 'oh_auth/server'
require 'json'

module OhAuth
  module Endpoints
    describe AuthenticateUser do
      let(:app)    { OhAuth::Server }

      context "with a valid username and password" do
        before do
          User.create! 'john@example.com', 'secret'
        end

        it "returns a 200 status code" do
          post '/token', username: 'john@example.com', password: 'secret'
          expect(last_response.status).to eql 200
        end

        it "generates an access token" do
          AccessToken.stub(:generate) { 'the-access-token' }

          post '/token', username: 'john@example.com', password: 'secret'

          response = JSON.parse(last_response.body)
          expect(response['access_token']).to eql 'the-access-token'
        end

        it "generates a refresh token" do
          RefreshToken.stub(:generate) { 'the-refresh-token' }

          post '/token', username: 'john@example.com', password: 'secret'

          response = JSON.parse(last_response.body)
          expect(response['refresh_token']).to eql 'the-refresh-token'
        end

        it "sets the token type" do
          post '/token', username: 'john@example.com', password: 'secret'

          response = JSON.parse(last_response.body)
          expect(response['token_type']).to eql 'Bearer'
        end
      end

      context "with an invalid password" do
        it "returns a 401 status code" do
          User.create! 'john@example.com', 'secret'

          post '/token', username: 'john@example.com', password: 'foo'

          expect(last_response.status).to eql 401
        end
      end

      context "with an unknown username" do
        it "returns a 401 status code" do
          post '/token', username: 'foo@example.com', password: 'foo'

          expect(last_response.status).to eql 401
        end
      end
    end
  end
end
