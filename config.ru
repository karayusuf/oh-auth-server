require './lib/oh_auth/server'

use Rack::Reloader
run OhAuth::Server
