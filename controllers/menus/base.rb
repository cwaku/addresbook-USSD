# frozen_string_literal: true

module Menu
  class Base
    def initialize(params)
      @params = params
      @tracker = params[:tracker]
      @activity_type = @params[:activity_type] || @tracker&.activity_type
      @ussd_body = @params[:ussd_body]
      @message_prepend = @params[:message_prepend].to_s
      @mobile_number = @params[:msisdn]
      @session_id = @params[:session_id]
      initialize_pages
    end

    def fetch_data
      @cache = Cache.fetch(@params).cache
      @data = JSON.parse(@cache).with_indifferent_access
      # Get all contacts that belongs to user_number index
      # @data = Contact.where(user_number: user_number)
    end

    def display_contatcs(user_number)
      @contacts = Contact.where(user_number: user_number)
      message = ''
      @contacts.each do |contact, index|
        message += <<~MSG
          #{index + 1}. First Name: #{contact.first_name} Last Name: #{contact.last_name} Phone: #{contact.phone_number}
        MSG
      end
      message
    end

    def store_data(new_data)
      fetch_data
      Cache.store(@params.merge(cache: @data.merge(new_data).to_json))
    end

    def self.process(params)
      new(params).process
    end

    def end_session(message = 'Service Unavailable. Please try again later')
      Session::Manager.end(
        @params.merge(display_message: message)
      )
    end

    def display_main_menu(options = {})
      # TODO: Add logic to display main menu
      @params[:page] = '1'
      Page::Main::First.process(@params.merge(options))
    end

    def display_page(options)
      # TODO: Add logic to display page
      # set tracker here
      params = @params.merge(options)

      # TODO: Add logic to check page for necessary routing and page display

      ActivityTracker.create({
                               mobile_number: @mobile_number,
                               ussd_body: params[:ussd_body],
                               session_id: params[:session_id],
                               menu_function: params[:menu_function],
                               page: params[:page],
                               activity_type: params[:activity_type],
                               message_type: params[:msg_type]
                             })

      Session::Manager.continue(@params.merge(display_message: display_message))
    end

    private

    def initialize_pages
      @page = @params[:page] || @tracker&.page
      # @pagination_page = @tracker&.pagination_page.to_i
      # @page = '1' if @page.nil?
      # @page = @page.to_i
    end
  end
end
