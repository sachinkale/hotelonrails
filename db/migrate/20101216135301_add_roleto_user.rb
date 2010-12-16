class AddRoletoUser < ActiveRecord::Migration
  def self.up
    add_column :users,:role_id,:integer
  end

  def self.down
    remove_column :users,:role_id
  end
end
