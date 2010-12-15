class AddDescriptionToCheckins < ActiveRecord::Migration
  def self.up
    add_column :checkins, :description, :text
  end

  def self.down
    remove_column :checkins, :description
  end
end
