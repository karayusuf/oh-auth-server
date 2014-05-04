require 'spec_helper'
require 'oh_auth/models/token'

module OhAuth
  describe Token do
    describe ".generate" do
      it "stores the token" do
        generated_token = AccessToken.generate
        expect(DataStore).to have_key("access_token:#{generated_token}")
      end

      it "keeps the token for 3600 seconds" do
        generated_token = AccessToken.generate

        life_span = DataStore::DB.ttl("access_token:#{generated_token}")
        expect(life_span).to eql 3600
      end
    end
  end
end

