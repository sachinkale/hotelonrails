class AddCompanyIdToCheckins < ActiveRecord::Migration
  def self.up
    add_column :checkins, :company_id, :integer
  end

  def self.down
    remove_column :checkins, :company_id
  end
end
