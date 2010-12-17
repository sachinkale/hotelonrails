class AddStatusToRooms < ActiveRecord::Migration
  def self.up
    add_column :rooms, :status, :string
  end

  def self.down
    remove_column :rooms, :status
  end
end
