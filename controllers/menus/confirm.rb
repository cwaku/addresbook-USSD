# frozen_string_literal: true

module Menu
  class Confirm < Menu::Base
    def process
      case @page
      when '1'
        Page::Confirm::Save.process(@params)
      end
    end
  end
end
