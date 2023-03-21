# frozen_string_literal: true

module Page
  module Contact
    module Create
      class First < Menu::Base
        def process
          case @activity_type
          when REQUEST
            display_current_page
          when RESPONSE
            process_response
          end
        end

        def process_response
          save_data
          Page::Contact::Create::Last.process(@params.merge({ activity_type: REQUEST, page: '2',
                                                              menu_function: 'add_contact' }))
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '1',
                         menu_function: ADD_CONTACT
                       })
        end

        def display_message
          # display message
          message = <<~MSG
            Please enter the first name of the contact
          MSG
          # message

          # set @message_prepend to message
          @message_prepend + message
        end

        def save_data
          store_data({ first_name: @ussd_body })
        end
      end
    end
  end
end
