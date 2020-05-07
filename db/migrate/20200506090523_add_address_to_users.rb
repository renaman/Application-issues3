class AddAddressToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :street, :string
  	add_column :users, :prefecture, :string
  	add_column :users, :country, :string
  	add_column :users, :latitude, :float
  	add_column :users, :longitude, :float
  end
end
