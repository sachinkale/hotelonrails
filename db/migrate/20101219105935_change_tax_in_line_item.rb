class ChangeTaxInLineItem < ActiveRecord::Migration
  def self.up
    change_column :line_items, :tax, :decimal
  end

  def self.down
   change_column :line_items, :tax, :integer
  end
end
