class CreateLaundryServices < ActiveRecord::Migration
  def self.up
    create_table :laundry_services do |t|
      t.integer :BillNumber
      t.integer :Amount

      t.timestamps
    end
  end

  def self.down
    drop_table :laundry_services
  end
end
