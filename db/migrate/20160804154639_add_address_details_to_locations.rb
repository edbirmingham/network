class AddAddressDetailsToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :address_one, :string
    add_column :locations, :address_two, :string
    add_column :locations, :city, :string
    add_column :locations, :state, :string
    add_column :locations, :zip_code, :string
  end
end
