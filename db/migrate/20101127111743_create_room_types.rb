class CreateRoomTypes < ActiveRecord::Migration
  def self.up
    create_table :room_types do |t|
      t.string :name
      t.text :facilities

      t.timestamps
    end
  end

  def self.down
    drop_table :room_types
  end
end
