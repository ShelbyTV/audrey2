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

  feed_keys = redis.keys(params[:type] ? "#{params[:type]}:*" : '*')
  feeds = feed_keys.map do |key|
    feed = redis.hgetall(key)
    feed["id"] = key
    feed
  end

  json :feeds => feeds
end