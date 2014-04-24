require 'set'

module OhAuth
  module Registrar
    Client = Struct.new(:name, :redirect_uri)

    def self.clients
      @clients ||= Set.new
    end

    def self.register_client(name, redirect_uri)
      clients << Client.new(name, redirect_uri)
    end
  end
end
