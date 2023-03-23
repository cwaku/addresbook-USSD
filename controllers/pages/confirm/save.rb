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
        first_name = @data[:first_name] || @data['contact']['firstname']
        last_name = @data[:last_name] || @data['contact']['lastname']
        mobile_number = @data[:mobile_number] || @data['contact']['phone']
        message = <<~MSG
          Details:
          Name: #{first_name} #{last_name}
          Number: #{mobile_number}

          1. Proceed & return to menu
          2. Cancel and return to menu

          00. Cancel and exit
        MSG

        @message_prepend + message
      end
    end
  end
end
