# frozen_string_literal: true

module Menu
  class Manager < Menu::Base
    def process
      tracker = ActivityTracker.where(mobile_number: @mobile_number,
                                      session_id: @session_id).order('created_at DESC').first
      params = @params.merge(tracker: tracker)
      case tracker.menu_function
      when 'main_menu'
        Menu::Main.process(params)
      when 'add_contact'
        Menu::Create::Contact.process(params)
      when 'edit_contact'
        Menu::Edit::Contact.process(params)
      when 'view_contact'
        Menu::View::Contact.process(params)
      when 'confirmation'
        Menu::Confirm.process(params)
      end
    end
  end
end
