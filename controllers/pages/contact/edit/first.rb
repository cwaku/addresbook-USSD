# frozen_string_literal: true

module Page
  module Contact
    module Edit
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
          case @ussd_body
          when '00'
            Page::Contact::Edit::Last.process(@params.merge({ activity_type: REQUEST, page: '2',
                                                              contact: @params[:contact] }))
          else
            # @params[:contact]['firstname'] = @ussd_body
            save_data
          end
          Page::Contact::Edit::Last.process(@params.merge({ activity_type: REQUEST }))
          # end
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '2',
                         menu_function: EDIT_CONTACT
                       })
        end

        def display_message
          fetch_data
          # display message
          message = <<~MSG
            Enter first name, or 00 to keep "#{@data[:contact]['firstname']}"
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
