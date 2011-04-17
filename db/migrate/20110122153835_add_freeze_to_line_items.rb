class AddFreezeToLineItems < ActiveRecord::Migration
  def self.up
    add_column :line_items, :freeze, :boolean
  end

  def self.down
    remove_column :line_items, :freeze
  end
end
