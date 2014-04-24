require 'spec_helper'
require 'oh_auth/registrar'

module OhAuth
  describe Registrar do
    describe "#register_client" do
      before do
        Registrar.clients.clear
      end

      it "registers new clients" do
        Registrar.register_client('Foo', 'http://foo.example.com')

        clients = Registrar.clients.map(&:name)
        expect(clients).to eql ['Foo']
      end

      it "does not register an client that has already been registered" do
        Registrar.register_client('Bar', 'http://bar.example.com')
        Registrar.register_client('Bar', 'http://bar.example.com')

        clients = Registrar.clients.map(&:name)
        expect(clients).to eql ['Bar']
      end
    end
  end
end

