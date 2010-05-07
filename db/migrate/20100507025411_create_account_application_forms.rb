class CreateAccountApplicationForms < ActiveRecord::Migration
  def self.up
    create_table :account_application_forms do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :account_application_forms
  end
end
