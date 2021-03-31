class AddLocationstoPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :location, :string
  end
end
