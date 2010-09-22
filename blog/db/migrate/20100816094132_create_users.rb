class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :password
      t.integer :mobile_no
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
