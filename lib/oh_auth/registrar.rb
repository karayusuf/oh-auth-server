require 'set'

module OhAuth
  module Registrar
    Application = Struct.new(:name, :redirect_uri)

    def self.applications
      @applications ||= Set.new
    end

    def self.register_application(name, redirect_uri)
      applications << Application.new(name, redirect_uri)
    end
  end
end
