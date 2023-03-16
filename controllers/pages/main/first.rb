# frozen_string_literal: true

module Page
  module Main
    class First < Menu::Base
      def process
        # TODO: Add logic to check and render page with activity type
        case @activity_type
        when 'request'
          display_current_page
        when 'response'
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
          # display_page({
          #                activity_type: 'request',
          #                page: '2',
          #                menu_function: 'add_contact'
          #              })
          Page::Contact::First.process(@params.merge({ activity_type: 'request', page: '1',
                                                       menu_function: 'add_contact' }))
        when '2'
          # TODO: Add logic to handle option 2 to view contacts
          display_page({
                         activity_type: 'request',
                         page: '2',
                         menu_function: 'view_contacts'
                       })
        end
      end

      def display_current_page
        # display current page
        display_page({
                       activity_type: 'response',
                       page: '1',
                       menu_function: 'main_menu'
                     })
      end

      def display_message
        # display message
        message = <<~MSG
          Welcome to address book app. Please select an option
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