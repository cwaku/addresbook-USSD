# frozen_string_literal: true

module Page
  module Contact
    class Last < Menu::Base
      def process
        case @activity_type
        when 'request'
          display_current_page
        when 'response'
          process_response
        end
      end

      private

      def process_response
        puts 'Processing response for last name of contact'
        Page::Contact::Phone.process(@params.merge({ activity_type: 'request', page: '3',
                                                     menu_function: 'add_contact' }))
      end

      def display_current_page
        display_page({
                       activity_type: 'response',
                       page: '2',
                       menu_function: 'add_contact'
                     })
      end

      def display_message
        # display message
        message = <<~MSG
          Please enter the last name of the contact
        MSG
        # message

        # set @message_prepend to message
        @message_prepend + message
      end
    end
  end
end