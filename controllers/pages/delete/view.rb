# frozen_string_literal: true

module Page
  module Contact
    module Delete
      class View < Menu::Base
        def process
          case @activity_type
          when REQUEST
            # TODO: Add logic to handle request for first name of contact
            display_current_page
          when RESPONSE
            process_response
          end
        end

        # TODO: Check menu_function and page to determine if this is the correct page

        def process_response
          # TODO: Add logic to save first name of contact
          case @ussd_body
          when '0'
            Page::Main::First.process(@params.merge({ activity_type: REQUEST }))
          else
            Page::Contact::Edit::First.process(@params.merge({ activity_type: REQUEST, page: '2',
                                                               menu_function: 'add_contact' }))
          end
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '1',
                         menu_function: DELETE_CONTACT
                       })
        end

        def display_message
          message = display_contatcs(@mobile_number)
          update_message = <<~MSG
            Please select the contact you want to delete
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
end