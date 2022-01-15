class AddBrowserToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :ip_address, :string
    add_column :bookings, :browser_name, :string
    add_column :bookings, :os_name, :string
  end
end
