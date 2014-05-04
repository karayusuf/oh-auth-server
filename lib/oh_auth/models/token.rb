require 'digest/sha1'

module OhAuth
  class Token

    def self.generate
      token = Digest::SHA1.hexdigest "#{salt} #{current_time}"
      DataStore.create!("#{key}:#{token}", expires_in: 3600)
      token
    end

    private

    def self.current_time
      Time.now.to_i
    end

    def self.salt
      rand(100_000_000_000)
    end

  end

  class AccessToken < Token
    def self.key
      "access_token"
    end
  end

  class RefreshToken < Token
    def self.key
      "refresh_token"
    end
  end
end

