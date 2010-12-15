class RoomTypes < ActiveRecord::Migration
  def self.up
    add_column :baserate, :integer
  end

  def self.down
    remove_column :baserate
  end
end
