require 'spec_helper'
require 'oh_auth/registrar'

module OhAuth
  describe Registrar do
    describe "#register_application" do
      before do
        Registrar.applications.clear
      end

      it "registers new applications" do
        Registrar.register_application('Foo', 'http://foo.example.com')

        applications = Registrar.applications.map(&:name)
        expect(applications).to eql ['Foo']
      end

      it "does not register an application that has already been registered" do
        Registrar.register_application('Bar', 'http://bar.example.com')
        Registrar.register_application('Bar', 'http://bar.example.com')

        applications = Registrar.applications.map(&:name)
        expect(applications).to eql ['Bar']
      end
    end
  end
end

