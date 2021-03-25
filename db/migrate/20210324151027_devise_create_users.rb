# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :password_digest
      t.string :token
      t.string :username
      t.string :role
      t.text :name

      t.timestamps
    end

  end
end
