# frozen_string_literal: true

module Page
  class Base < Menu::Base
    # def initialize(params)
    #   @page = params[:page]
    #   @tracker = params[:tracker]
    #   @mobile_number = params[:msisdn]
    #   @ussd_body = params[:ussd_body]
    #   @session_id = params[:session_id]
    #   @params = params
    # end

    def self.process(params)
      new(params).process
    end

    # def process
    #   case @activity_type
    #   when REQUEST
    #     display_current_page
    #   when RESPONSE
    #     process_response
    #   end
    # end

    # private

    # process response method that takes a clase name, activity type, page and menu function as arguments calss the process method of the class
    def process_response(options = {})
      # check if menu function is add_contact
      case options[:menu_function]
      when 'add_contact'
        Menu::Manager.process(@params.merge(activity_type: REQUEST))
      when 'edit_contact'
        class_object = Page::Contact::Edit.const_get(options[:class_name]) # get class name TODO: add capitalization
        class_object.process(@params.merge({ activity_type: REQUEST, page: options[:page],
                                             menu_function: options[:menu_function] }))
      end
    end

    def display_current_page(options)
      display_page(options)
    end

    def display_message(message = @params[:message])
      @message_prepend + message
    end
  end
end
