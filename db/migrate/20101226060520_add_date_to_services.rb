class AddDateToServices < ActiveRecord::Migration
  def self.up
    add_column :services, :date, :datetime
  end

  def self.down
    remove_column :services, :date
  end
end
