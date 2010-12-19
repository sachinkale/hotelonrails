class AddPrecisionToTaxLineItem < ActiveRecord::Migration
  def self.up
    change_column :line_items, :tax, :decimal, :options => {:precision => "3",:scale => "2"}
  end

  def self.down
    change_column :line_items, :tax, :decimal
  end
end
