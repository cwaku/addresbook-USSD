# frozen_string_literal: true

module Menu
  class Base
    def initialize(params)
      @params = params
      @activity_type = @params[:activity_type]
      @ussd_body = @params[:ussd_body]
      @message_prepend = @params[:message_prepend]
      @mobile_number = @params[:msisdn]
      @session_id = @params[:session_id]
      initialize_pages
    end

    def self.process(params)
      new(params).process
    end

    def display_main_menu(options = {})
      # TODO: Add logic to display main menu
      @params[:page] = '1'
      Page::Main::First.process(@params.merge(options))
    end

    def display_page(options)
      # TODO: Add logic to display page
      # set tracker here

      Session::Manager.continue(@params.merge(display_message: display_message))
    end

    private

    def initialize_pages
      @page = @params[:page]
      @page = '1' if @page.nil?
      # @page = @page.to_i
    end
  end
end
