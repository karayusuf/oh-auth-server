require 'oh_auth/data_store'

module OhAuth
  class DuplicateUser < StandardError
  end

  class User

    def self.key_for(username)
      "user:#{username.downcase}"
    end

    def self.create!(username, password)
      key  = key_for(username)
      user = DataStore.create!(key, username: username, password: password)
      user or fail DuplicateUser.new(username)
    end

    def self.find(username)
      key = key_for(username)
      attrs = DataStore.find(key) do
        { 'username' => 'InvalidUser' }
      end

      new(attrs['username'], attrs['password'])
    end

    attr_reader :username, :password

    def initialize(username, password)
      @username = username
      @password = password
    end

    def authenticate?(password)
      @password == password
    end

  end
end

