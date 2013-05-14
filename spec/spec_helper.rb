require './audrey2'
require 'rspec'
require 'rspec/autorun'
require 'rack/test'
require 'json_spec'
# Require your modules here
# this is how i do it:
# require_relative '../sinatra_modules'

def app
  Sinatra::Application # It is must and tell rspec that test it running is for sinatra
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include JsonSpec::Helpers
  config.order = 'random'
end