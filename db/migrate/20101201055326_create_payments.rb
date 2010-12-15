class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :amount
      t.integer :checkin_id

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
