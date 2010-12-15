class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.integer :room_id
      t.integer :extraperson
      t.integer :tax
      t.datetime :fromdate
      t.datetime :todate
      t.integer :rate
      t.integer :checkin_id

      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
