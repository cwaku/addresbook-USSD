# frozen_string_literal: true

module Menu
  module Delete
    # Menu manager for create contact
    class Contact < Menu::Base
      def process
        case @page
        when '1'
          Page::Contact::Delete::View.process(@params)
        end
      end
    end
  end
end
