class CreateServiceItems < ActiveRecord::Migration
  def self.up
    create_table :service_items do |t|
      t.integer :service_id
      t.integer :amount
      t.integer :billnumber
      t.text :description
      t.integer :checkin_id

      t.timestamps
    end
  end

  def self.down
    drop_table :service_items
  end
end
