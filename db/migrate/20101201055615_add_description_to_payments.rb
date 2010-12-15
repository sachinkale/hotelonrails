class AddDescriptionToPayments < ActiveRecord::Migration
  def self.up
    add_column :payments, :description, :text
  end

  def self.down
    remove_column :payments, :description
  end
end
