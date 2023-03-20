# frozen_string_literal: true

module Menu
  module Create
    # Menu manager for create contact
    class Contact < Menu::Base
      def process
        case @page
        when '1'
          Page::Contact::Create::First.process(@params)
        when '2'
          Page::Contact::Create::Last.process(@params)
        when '3'
          Page::Contact::Create::Phone.process(@params)
        end
      end
    end
  end
end
