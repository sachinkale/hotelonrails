class CreateRoomServices < ActiveRecord::Migration
  def self.up
    create_table :room_services do |t|
      t.integer :BillNumber
      t.integer :Amount

      t.timestamps
    end
  end

  def self.down
    drop_table :room_services
  end
end
