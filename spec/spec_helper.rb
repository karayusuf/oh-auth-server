require 'rspec'
require 'rack/test'

require 'oh_auth/registrar'
require 'oh_auth/models/user'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = :documentation

  config.include Rack::Test::Methods

  config.before do
    OhAuth::Registrar.clients.clear
    OhAuth::DataStore::DB.flushdb
  end
end
