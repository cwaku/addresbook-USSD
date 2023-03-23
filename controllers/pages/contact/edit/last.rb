# frozen_string_literal: true

module Page
  module Contact
    module Edit
      class Last < Menu::Base
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
            Page::Contact::Edit::Region.process(@params.merge({ activity_type: REQUEST, contact: @params[:contact] }))
          else
            # @params[:contact]['lastname'] = @ussd_body
            save_data
          end
          Page::Contact::Edit::Region.process(@params.merge({ activity_type: REQUEST }))
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '3',
                         menu_function: EDIT_CONTACT
                       })
        end

        def display_message
          fetch_data
          # display message
          message = <<~MSG
            Enter last name, or 00 to keep "#{@data[:contact]['lastname']}"
          MSG
          # message

          # set @message_prepend to message
          @message_prepend + message
        end

        def save_data
          store_data({ last_name: @ussd_body })
        end
      end
    end
  end
end
