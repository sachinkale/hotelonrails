class Createguestscheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins_guests do |t|
      t.integer :checkin_id
      t.integer :guest_id
    end
      
  end

  def self.down
    drop_table :checkins_guests
  end
end
