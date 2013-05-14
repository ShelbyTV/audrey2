# audrey2.rb
require 'sinatra'

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