class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :inchargeperson
      t.text :address
      t.string :email
      t.string :phone
      t.integer :creditlimit

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
