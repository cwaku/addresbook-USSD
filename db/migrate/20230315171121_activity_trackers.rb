# frozen_string_literal: true

class ActivityTrackers < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_trackers do |t|
      t.string :session_id
      t.string :mobile_number
      t.string :menu_function
      t.string :page, default: ''
      t.string :message_type
      t.string :ussd_body
      t.string :activity_type

      t.timestamps null: false
    end

    add_index :activity_trackers, :mobile_number
  end
end
