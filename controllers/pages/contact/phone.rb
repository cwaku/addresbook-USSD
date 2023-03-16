# frozen_string_literal: true

module Page
  module Contact
    class Phone < Menu::Base
      def process
        case @activity_type
        when 'request'
          display_current_page
        when 'response'
          process_response
        end
      end

      private

      def process_response; end

      def display_current_page
        display_page({
                       activity_type: 'response',
                       page: '3',
                       menu_function: 'add_contact'
                     })
      end

      def display_message
        # display message
        message = <<~MSG
          Please enter the phone number of the contact
        MSG
        # message

        # set @message_prepend to message
        @message_prepend + message
      end
    end
  end
end
