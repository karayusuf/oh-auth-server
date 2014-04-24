require 'spec_helper'
require 'oh_auth/registrar'

module OhAuth
  describe Registrar do
    describe "#register_application" do
      let(:registrar) { Registrar.new }

      it "registers new applications" do
        registrar.register_application('Foo', 'http://foo.example.com')

        applications = registrar.applications.map(&:name)
        expect(applications).to eql ['Foo']
      end

      it "does not register an application that has already been registered" do
        registrar.register_application('Foo', 'http://foo.example.com')
        registrar.register_application('Foo', 'http://foo.example.com')

        applications = registrar.applications.map(&:name)
        expect(applications).to eql ['Foo']
      end
    end
  end
end

