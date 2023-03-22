# frozen_string_literal: true

class AddPhoneUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone, :string
  end
end
