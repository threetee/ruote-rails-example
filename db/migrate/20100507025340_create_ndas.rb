class CreateNdas < ActiveRecord::Migration
  def self.up
    create_table :ndas do |t|
      t.references :email
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :ndas
  end
end
