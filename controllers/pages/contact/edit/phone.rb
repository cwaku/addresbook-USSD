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
          Page::Main::First.process(@params.merge({ activity_type: REQUEST }))
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '3',
                         menu_function: 'edit_contact'
                       })
        end

        def display_message
          # display message
          message = <<~MSG
            Please enter the phone number of the contact
          MSG
          # messagedWgpo%Rjb^iyc4%

          # set @message_prepend to message
          @message_prepend + message
        end
      end
    end
  end
end
