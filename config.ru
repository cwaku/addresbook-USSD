# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'rubocop'

disable :run, :reload

require './app'
require './controllers/init'
# require './models/init'
# reqiure './utils/init'

run Sinatra::Application
