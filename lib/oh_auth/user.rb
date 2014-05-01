module OhAuth
  class DuplicateUser < StandardError
  end

  class User

    def self.all
      @users ||= []
    end

    def self.create!(username, password)
      if find(username)
        raise DuplicateUser.new(username)
      else
        all << new(username, password)
      end
    end

    def self.find(username)
      all.detect { |user| user.username.downcase == username.downcase }
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

