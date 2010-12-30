class AddBillToCheckins < ActiveRecord::Migration
  def self.up
    add_column :checkins, :bill_to, :integer
    add_column :checkins, :bill_to_owner, :string
  end

  def self.down
    remove_column :checkins, :bill_to_owner
    remove_column :checkins, :bill_to
  end
end
