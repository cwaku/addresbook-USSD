# frozen_string_literal: true

module Page
  module Confirm
    class Save < Menu::Base
      def process
        fetch_data
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
        when '1'
          # Save contact here
          save_info
          display_main_menu({ activity_type: REQUEST })
        when '2'
          display_main_menu({ activity_type: REQUEST })
        when '00'
          end_session('Process Aborted')
        else
          @message_prepend = "Inavlid Option \n"
          display_current_page
        end
      end

      def display_current_page
        display_page({
                      page: '1',
                      menu_function: CONFIRMATION,
                      activity_type: RESPONSE
                    })
      end

      def display_message
        message = <<~MSG
          You have selected

          1. Proceed and return to main menu
          2. Cancel and return to main menu

          00. Cancel and exit app
        MSG

        @message_prepend + message
      end

      
      
    end
  end
end
