# frozen_string_literal: true

# require 'faraday'
# require 'json'

# class APIClient
#   def initialize(model)
#     @uri = "http://127.0.0.1:3049/#{model}"
#   end

#   attr_reader :uri

#   def index
#     @response = Faraday.get(@uri)
#     show_resp
#   end

#   def create(params)
#     body = {
#       @model => params
#     }
#     @response = Faraday.post @uri, body, nil
#     show_resp
#   end

#   private

#   def show_resp
#     @body = JSON.parse @response.body
#     @status = @response.status
#     puts "Status -> #{@status}"
#     # puts @body
#   end
# end

# contacts_api = APIClient.new("contacts")

# puts "The contacts api is located at #{contacts_api.uri}"

# contacts_api.index

# params = {
#   firstname: "John",
#   lastname: "Doe",
#   phone: "0700000000",
#   remarks: "Holssss",
#   user_id: "33",
#   suburb_id: "1"
# }
# contacts_api.create(params)
