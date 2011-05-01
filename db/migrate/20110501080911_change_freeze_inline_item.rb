class ChangeFreezeInlineItem < ActiveRecord::Migration
  def self.up
    rename_column(:line_items, :freeze, :freez)
  end

  def self.down
  end
end
