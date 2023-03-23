# frozen_string_literal: true

module Page
  module Contact
    module Edit
      class City < Menu::Base
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
          Page::Contact::Edit::Suburb.process(@params.merge({ activity_type: REQUEST, page: '3',
                                                              menu_function: EDIT_CONTACT }))
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '5',
                         menu_function: EDIT_CONTACT
                       })
        end

        def display_message
          message = display_cities
          update_message = <<~MSG
            Select city
          MSG
          @message_prepend + update_message + message
        end

        def save_data
          # Find suburb_id from database
          ussd_body = @ussd_body.to_i
          display_cities
          if ussd_body.positive? && ussd_body <= @cities.count
            # find region with ussd_body
            city = @cities[ussd_body - 1]
            # find region_id
            @city_id = city.id
          end
          # suburb_id = Suburb.find_by(name: @ussd_body).id
          store_data({ city_id: @city_id, menu_function: ADD_CONTACT, user_number: @mobile_number })
        end
      end
    end
  end
end
