require 'digest/sha1'

module OhAuth
  class Token

    def self.generate
      Digest::SHA1.hexdigest "#{salt} #{current_time}"
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
  end

  class RefreshToken < Token
  end
end

