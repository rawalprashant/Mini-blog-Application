class AddColumnUserImageToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :user_image, :string
  end

  def self.down
    remove_column :users, :user_image
  end
end
