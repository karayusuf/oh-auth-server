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
          post '/login', username: 'john@example.com', password: 'secret'
          expect(last_response.status).to eql 200
        end

        it "returns an access token" do
          post '/login', username: 'john@example.com', password: 'secret'

          response = JSON.parse(last_response.body)
          expect(response).to have_key 'access_token'
        end
      end

      context "with an invalid password" do
        it "returns a 401 status code" do
          User.create! 'john@example.com', 'secret'

          post '/login', username: 'john@example.com', password: 'foo'

          expect(last_response.status).to eql 401
        end
      end

      context "with an unknown username" do
        it "returns a 401 status code" do
          post '/login', username: 'foo@example.com', password: 'foo'

          expect(last_response.status).to eql 401
        end
      end
    end
  end
end
