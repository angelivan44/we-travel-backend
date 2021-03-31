class AddPropertiestoUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :location, :string
    add_column :users, :birthdate, :date
    add_column :users, :social, :string
    add_column :users, :description, :text
  end
end
