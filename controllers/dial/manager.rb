# frozen_string_literal: true

module Dial
  class Manager
    def initialize(json)
      params = JSON.parse(json)&.with_indifferent_access
      @params = params
    end

    def process
      puts @params
    end
  end
end
