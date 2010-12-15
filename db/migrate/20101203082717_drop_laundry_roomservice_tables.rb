class DropLaundryRoomserviceTables < ActiveRecord::Migration
  def self.up
    drop_table :laundry_services
  end

  def self.down
  end
end
