# frozen_string_literal: true

module Page
  module Contact
    module Create
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
          save_data
          Page::Confirm::Save.process(@params.merge(activity_type: REQUEST))
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '3',
                         menu_function: ADD_CONTACT
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

        def save_data
          store_data({ mobile_number: @ussd_body, menu_function: ADD_CONTACT, user_number: @mobile_number })
        end
      end
    end
  end
end
