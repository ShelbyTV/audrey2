# audrey2.rb
require 'sinatra'
require 'sinatra/json'
require 'multi_json'
require 'redis'

configure :development, :test do
  set :bind, '0.0.0.0'
end

get '/' do
  if settings.development?
    'Welcome to audrey2'
  else
    not_found
  end
end

get '/v1/feeds' do
  redis = Redis.new

  feed_keys = redis.keys 'youtube:*'

  feed_keys.each {|key| puts key}

  json :feeds => ['x', 'y']
end