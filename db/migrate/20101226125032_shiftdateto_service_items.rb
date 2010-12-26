class ShiftdatetoServiceItems < ActiveRecord::Migration
  def self.up
    remove_column :services, :date
    add_column :service_items, :date, :datetime
  end

  def self.down
    add_column :services, :date,:datetime
    remove_column :service_items, :date

  end
end
