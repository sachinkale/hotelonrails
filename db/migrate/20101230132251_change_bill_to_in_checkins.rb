class ChangeBillToInCheckins < ActiveRecord::Migration
  def self.up
    remove_column :checkins, :bill_to
    add_column :checkins, :bill_to_owner_id, :integer
  end

  def self.down
    remove_column :checkins, :bill_to_owner_id
    add_column :checkins, :bill_to, :integer

  end
end
