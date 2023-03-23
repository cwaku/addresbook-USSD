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
      # validate_user
      # TODO: Add logic to handle initial dial
      # if user exists proceed else end session
      user? ? Menu::Main.process(@params.merge(page: '1', activity_type: REQUEST)) : end_session
    end

    def continous_dial
      # TODO: Add logic to handle continous dial
      Menu::Manager.process(@params)
    end

    def user?
      user = User.find_by('RIGHT(phone, 9) = ?', @params[:msisdn].last(9))
      !user.nil?
    end

    def end_session(message = 'You are unauthorised to use this service')
      Session::Manager.end(
        @params.merge(display_message: message)
      )
    end
  end
end
