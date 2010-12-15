class AddRoomIdToServiceItems < ActiveRecord::Migration
  def self.up
    add_column :service_items, :room_id, :integer
  end

  def self.down
    remove_column :service_items, :room_id
  end
end
