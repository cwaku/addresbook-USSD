# frozen_string_literal: true

module Page
  module Contact
    module Edit
      class Suburb < Menu::Base
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
          Page::Contact::Edit::Phone.process(@params.merge({ activity_type: REQUEST, page: '3',
                                                             menu_function: EDIT_CONTACT }))
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '6',
                         menu_function: EDIT_CONTACT
                       })
        end

        def display_message
          message = display_suburbs
          update_message = <<~MSG
            Select suburb
          MSG
          @message_prepend + update_message + message
        end

        def save_data
          # Find suburb_id from database
          ussd_body = @ussd_body.to_i
          display_suburbs
          if ussd_body.positive? && ussd_body <= @suburbs.count
            # find region with ussd_body
            suburb = @suburbs[ussd_body - 1]
            # find suburb_id
            @suburb_id = suburb.id
          end
          #   suburb_option = @ussd_body.to_i
          #   suburb_id = Suburb.find_by(name: @ussd_body).id
          store_data({ suburb_id: @suburb_id, menu_function: ADD_CONTACT, user_number: @mobile_number })
        end
      end
    end
  end
end
