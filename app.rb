# frozen_string_literal: true

require 'sinatra'

post '/' do
  Dial::Manager.rew(request.body.read).process
end
