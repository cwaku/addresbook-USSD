# frozen_string_literal: true

module Menu
  module View
    # Menu manager for create contact
    class Contact < Menu::Base
      def process
        case @page
        when '1'
          Page::Contact::View.process(@params)
        when '2'
          Page::Contact::First.process(@params)
        when '3'
          Page::Contact::Last.process(@params)
        when '4'
          Page::Contact::Phone.process(@params)
        end
      end
    end
  end
end
