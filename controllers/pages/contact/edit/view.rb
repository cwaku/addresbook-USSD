# frozen_string_literal: true

module Page
  module Contact
    module Edit
      class View < Menu::Base
        def process
          fetch_data
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
            store_data(contacts: @contacts)
            ussd_body = @ussd_body.to_i
            puts "DAAAAAAAAAAAAATTTAA #{@data}"
            if ussd_body.positive? && ussd_body <= @data.count
              contact = @data[ussd_body - 1]
              Page::Contact::Edit::First.process(@params.merge({ activity_type: REQUEST, page: '2',
                                                                 menu_function: EDIT_CONTACT, contact: contact }))
            end
          end
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '1',
                         menu_function: EDIT_CONTACT
                       })
        end

        def display_message
          message = display_contatcs(@mobile_number)
          update_message = <<~MSG
            Please select the contact you want to edit
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
