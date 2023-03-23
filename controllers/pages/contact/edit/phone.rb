# frozen_string_literal: true

module Page
  module Contact
    module Edit
      class Phone < Menu::Base
        def process
          case @activity_type
          when REQUEST
            display_current_page
          when RESPONSE
            process_response
          end
        end

        private

        def process_response
          case @ussd_body
          when '00'
            # TODO: Noting here
            puts 'NOTTTTTTTTHHHHHHIIIIIIIINGGGGGG'
          else
            save_data
          end
          puts 'NOTTTTTTTTHHHHHHIIIIIIIINGGGGGG'
          Page::Confirm::Save.process(@params.merge(activity_type: REQUEST))
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '7',
                         menu_function: EDIT_CONTACT
                       })
        end

        def display_message
          # display message
          fetch_data
          message = <<~MSG
            Enter phone number, or 00 to keep "#{@data[:contact]['phone']}"
          MSG
          # message

          # set @message_prepend to message
          @message_prepend + message
        end

        def save_data
          store_data({ mobile_number: @ussd_body, menu_function: EDIT_CONTACT, user_number: @mobile_number })
        end
      end
    end
  end
end
