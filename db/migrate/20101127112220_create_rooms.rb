class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :number
      t.integer :room_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
