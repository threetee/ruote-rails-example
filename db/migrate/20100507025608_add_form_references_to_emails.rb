class AddFormReferencesToEmails < ActiveRecord::Migration
  def self.up
    add_column :emails, :nda_id, :integer
    add_column :emails, :account_application_form_id, :integer
  end

  def self.down
    remove_column :emails, :account_application_form_id
    remove_column :emails, :nda_id
  end
end
