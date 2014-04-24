require 'set'

module OhAuth
  class Registrar

    Application = Struct.new(:name, :redirect_uri)

    attr_reader :applications

    def initialize
      @applications = Set.new
    end

    def register_application(name, redirect_uri)
      applications << Application.new(name, redirect_uri)
    end
  end
end
