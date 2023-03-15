# frozen_string_literal: true

module Menu
  class Main < Menu::Base
    def process
      case @page
      when '1'
        # TODO: Add logic to handle page 1
        Page::Main::First.process(@params)
      end
    end
  end
end
