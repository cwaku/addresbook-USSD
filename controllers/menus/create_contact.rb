# frozen_string_literal: true

module Menu
  class CreateContact < Menu::Base
    def process
      case @page
      when '1'
        Page::Contact::First.process(@params)
      when '2'
        Page::Contact::Last.process(@params)
      when '3'
        Page::Contact::Phone.process(@params)
      end
    end
  end
end
