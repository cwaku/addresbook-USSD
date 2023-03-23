# frozen_string_literal: true

module Page
  module Contact
    module Edit
      class Region < Menu::Base
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
          Page::Contact::Edit::City.process(@params.merge({ activity_type: REQUEST, page: '3',
                                                            menu_function: EDIT_CONTACT }))
        end

        def display_current_page
          display_page({
                         activity_type: RESPONSE,
                         page: '4',
                         menu_function: EDIT_CONTACT
                       })
        end

        def display_message
          message = display_regions
          update_message = <<~MSG
            Select region:
          MSG
          @message_prepend + update_message + message
        end

        def save_data
          # Find region_id from database
          ussd_body = @ussd_body.to_i
          display_regions
          if ussd_body.positive? && ussd_body <= @regions.count
            # find region with ussd_body
            region = @regions[ussd_body - 1]
            # find region_id
            @region_id = region.id
          end
          # suburb_id = Suburb.find_by(name: @ussd_body).id
          store_data({ region_id: @region_id, menu_function: ADD_CONTACT, user_number: @mobile_number })
        end
      end
    end
  end
end
