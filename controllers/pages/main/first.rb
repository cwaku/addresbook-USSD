# frozen_string_literal: true

module Page
  module Main
    class First < Menu::Base
      def process
        # TODO: Add logic to check and render page with activity type
        case @activity_type
        when REQUEST
          display_current_page
        when RESPONSE
          process_response
        end
      end

      private

      def process_response
        # Check ussd body and process response. Merge params with activity type
        # display error when option is not valid
        case @ussd_body
        when '1'
          # TODO: Add logic to handle option 1 to request for first name of contact
          Menu::Create::Contact.process(@params.merge({ activity_type: REQUEST }))
        when '2'
          # TODO: Add logic to handle option 2 to view contacts
          message = display_contatcs(@mobile_number)
          if message.empty?
            @message_prepend = "No Contacts. Please add some contacts \n"
            display_current_page
          else
            Menu::View::Contact.process(@params.merge({ activity_type: REQUEST }))
          end
        when '3'
          message = display_contatcs(@mobile_number)
          if message.empty?
            @message_prepend = "No Contacts. Please add some contacts \n"
            display_current_page
          else
            Menu::Delete::Contact.process(@params.merge({ activity_type: REQUEST }))
          end
        when '4'
          message = display_contatcs(@mobile_number)
          if message.empty?
            @message_prepend = "No Contacts. Please add some contacts \n"
            display_current_page
          else
            Menu::Edit::Contact.process(@params.merge({ activity_type: REQUEST }))
          end
        else
          @message_prepend = "Invalid Option. \n"
          display_current_page
        end
      end

      def display_current_page
        # display current page
        display_page({
                       activity_type: RESPONSE,
                       page: '1',
                       menu_function: MAIN_MENU
                     })
      end

      def display_message
        # display message
        message = <<~MSG
          Welcome. Please select an option
          1. Add contact
          2. View contacts
          3. Delete contact
          4. Update contact
        MSG
        # message

        # set @message_prepend to message
        @message_prepend + message
      end
    end
  end
end
