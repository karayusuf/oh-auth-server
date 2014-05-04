require 'redis'
require 'json'
require 'pry'

module OhAuth
  class DataStore
    DB = Redis.new

    def self.find(id, &block)
      data = DB.get(id)
      data ? JSON(data) : (block || not_found(id)).call
    end

    def self.has_key?(id)
      DB.exists(id)
    end

    def self.create!(id, attributes)
      expires_in = attributes[:expires_in]
      data       = JSON(attributes)

      if expires_in
        DB.setex(id, expires_in, data)
      else
        DB.setnx(id, data)
      end
    end

    private

    def self.not_found(id)
      -> { raise KeyError.new(id) }
    end

  end
end
