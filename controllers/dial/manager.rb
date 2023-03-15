# frozen_string_literal: true

module Dial
  # Constructs a new ussd class manager.
  class Manager
    def initialize(json)
      params = JSON.parse(json)&.with_indifferent_access
      @message_type = params[:msg_type]
      @params = params
    end

    def process
      case @message_type
      when '0'
        initial_dial
      when 'continous_dial'
        continous_dial
      end
    end

    private

    def initial_dial
      # TODO: Add logic to handle initial dial
    end

    def continous_dial
      # TODO: Add logic to handle continous dial
    end
  end
end
