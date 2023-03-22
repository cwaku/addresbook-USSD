# frozen_string_literal: true

module Page
  module Contact
    class View < Menu::Base
      def process
        case @activity_type
        when REQUEST
          display_current_page
        when RESPONSE
          process_response
        end
      end

      def process_response
        case @ussd_body
        when '00'
          Page::Main::First.process(@params.merge({ activity_type: REQUEST }))
        else
          # TODO: Redirect and attempt pagination
          Page::Contact::Edit::First.process(@params.merge({ activity_type: REQUEST, page: '2',
                                                             menu_function: 'add_contact' }))
        end
      end

      def display_current_page
        display_page({
                       activity_type: RESPONSE,
                       page: '1',
                       menu_function: 'view_contact'
                     })
      end

      def display_message
        message = display_contatcs(@mobile_number)
        update_message = <<~MSG
          All contacts
          00. Back
        MSG
        @message_prepend + update_message + message
        #   @message_prepend += message

        #   @data.each do |contact, index|
        #     @message_prepend += "#{index + 1}. #{contact.first_name} #{contact.last_name} #{contact.phone_number}"
        #   end
        # message = <<~MSG
        #   Please enter the first name of the contact
        # MSG
        # # message

        # # set @message_prepend to message
        # @message_prepend + message
      end
    end
  end
end
