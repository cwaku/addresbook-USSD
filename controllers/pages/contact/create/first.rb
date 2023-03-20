# frozen_string_literal: true

module Page
  module Contact
    module Create
      class First < Menu::Base
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
          # return unless @ussd_body.present?

          Page::Contact::Create::Last.process(@params.merge({ activity_type: REQUEST, page: '2',
                                                      menu_function: 'add_contact' }))
        end

        def display_current_page
          display_page({
                        activity_type: RESPONSE,
                        page: '1',
                        menu_function: 'add_contact'
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
      end
    end
  end
end
