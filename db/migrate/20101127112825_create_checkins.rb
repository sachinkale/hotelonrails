class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.datetime :fromdate
      t.datetime :todate
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :checkins
  end
end
