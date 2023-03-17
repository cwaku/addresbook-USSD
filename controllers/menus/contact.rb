# frozen_string_literal: true

module Menu
  class Contact < Menu::Base
    def process
      case @page
      when '1'
        message = <<~MSG
          Please enter the first name of the contact
        MSG
        Page::Contact::First.process(@params.merge({ activity_type: REQUEST, page: @page,
                                                     menu_function: ADD_CONTACT, message: message }))
      end
    end
  end
end
