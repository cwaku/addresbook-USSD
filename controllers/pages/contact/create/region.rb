# frozen_string_literal: true

module Page
    module Contact
      module Create
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
            Page::Contact::Create::City.process(@params.merge({ activity_type: REQUEST, page: '3',
                                                                 menu_function: ADD_CONTACT }))
          end
  
          def display_current_page
            display_page({
                           activity_type: RESPONSE,
                           page: '3',
                           menu_function: ADD_CONTACT
                         })
          end
  
          def display_message
            message = display_regions
            update_message = <<~MSG
              Select region
            MSG
            @message_prepend + update_message + message
          end
  
          def save_data
            # Find suburb_id from database
            suburb_option = @ussd_body.to_i
            suburb_id = Suburb.find_by(name: @ussd_body).id
            store_data({ suburb_id: suburb_id, menu_function: ADD_CONTACT, user_number: @mobile_number })
          end
        end
      end
    end
  end
  