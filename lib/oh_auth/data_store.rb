require 'redis'
require 'json'
require 'pry'

module OhAuth
  class DataStore
    DB = Redis.new

    def self.find(id)
      data = DB.get(id)
      data ? JSON(data) : {}
    end

    def self.create!(id, attributes)
      DB.setnx(id, JSON(attributes))
    end

  end
end
