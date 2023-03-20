# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile_number
      t.string :user_number

      t.timestamps null: false
    end

    add_index :contacts, :user_number
  end
end
