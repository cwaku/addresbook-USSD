# frozen_string_literal: true

class RemoveSubMenuFunctionToActivityTrackers < ActiveRecord::Migration[7.0]
  def change
    remove_column :activity_trackers, :sub_menu_function, :string, default: ''
  end
end
