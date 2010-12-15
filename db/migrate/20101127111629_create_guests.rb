class CreateGuests < ActiveRecord::Migration
  def self.up
    create_table :guests do |t|
      t.string :FirstName
      t.string :LastName
      t.integer :age
      t.string :sex
      t.string :photo
      t.text :address
      t.integer :mobile
      t.string :email
      t.date :birthdate

      t.timestamps
    end
  end

  def self.down
    drop_table :guests
  end
end
