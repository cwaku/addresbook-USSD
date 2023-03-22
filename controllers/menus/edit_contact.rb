# frozen_string_literal: true

module Menu
  module Edit
    # Menu manager for edit contact
    class Contact < Menu::Base
      def process
        case @page
        when '1'
          Page::Contact::Edit::View.process(@params)
        when '2'
          Page::Contact::Edit::First.process(@params)
        when '3'
          Page::Contact::Edit::Last.process(@params)
        when '4'
          Page::Contact::Edit::Region.process(@params)
        when '5'
          Page::Contact::Edit::City.process(@params)
        when '6'
          Page::Contact::Edit::Suburb.process(@params)
        when '7'
          Page::Contact::Edit::Phone.process(@params)
        end
      end
    end
  end
end
