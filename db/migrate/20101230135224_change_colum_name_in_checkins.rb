class ChangeColumNameInCheckins < ActiveRecord::Migration
  def self.up
    add_column :checkins, :bill_to_owner_type, :string
    remove_column :checkins, :bill_to_owner
  end

  def self.down
    add_column :checkins, :bill_to_owner, :string
    remove_column :checkins, :bill_to_owner_type

  end
end
