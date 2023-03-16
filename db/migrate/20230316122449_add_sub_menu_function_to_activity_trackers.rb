# frozen_string_literal: true

class AddSubMenuFunctionToActivityTrackers < ActiveRecord::Migration[7.0]
  def change
    add_column :activity_trackers, :sub_menu_function, :string, default: ''
  end
end
