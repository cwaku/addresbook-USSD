# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'rubocop'
require 'redis'

disable :run, :reload

configure do
  $redis = Redis.new(host: 'localhost', port: 6379)
end

require './app'
require './controllers/init'
require './models/init'
require './utils/init'

run Sinatra::Application
