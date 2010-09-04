class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :name
      t.string  :avatar_uid
      t.integer :avatar_width
      t.integer :avatar_height
      t.string  :avatar_cropping

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
