require 'spec_helper'
require 'oh_auth/models/user'

module OhAuth
  describe User do
    describe ".create!" do
      it "adds the user" do
        User.create!('john@example.com', 'secret-password')

        user = User.find('john@example.com')
        expect(user.username).to eql 'john@example.com'
      end

      it "raises an error when the username has been taken" do
        User.create!('john@example.com', 'secret-password')

        expect { User.create!('JOHN@example.cOM', 'foo')
        }.to raise_error DuplicateUser
      end
    end

    describe ".find" do
      it "finds users by username" do
        User.create!('john@example.com', 'secret-password')

        user = User.find('john@example.com')
        expect(user.username).to eql 'john@example.com'
      end

      it "returns nil when the user is not found" do
        user = User.find('foobar@example.com')
        expect(user.username).to eql 'InvalidUser'
      end

    end
  end
end

