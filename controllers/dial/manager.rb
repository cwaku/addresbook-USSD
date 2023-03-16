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
      when '1'
        continous_dial
      end
    end

    private

    def initial_dial
      # TODO: Add logic to handle initial dial
      # Menu::Main.process(@params.merge(page: '1', activity_type: 'request'))
      Menu::Main.process(@params.merge(page: '1', activity_type: 'request'))
    end

    def continous_dial
      # TODO: Add logic to handle continous dial
      Menu::Manager.process(@params)
    end
  end
end
