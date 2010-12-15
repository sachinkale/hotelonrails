class Help < ActiveRecord::Migration
  def self.up
    add_column :room_types,:baserate,:integer
  end

  def self.down
    remove_column :room_types,:baserate
  end
end
