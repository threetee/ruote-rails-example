class AccountApplicationForm < ActiveRecord::Base
  attr_accessible :name, :attachment
  
  belongs_to :email
  
  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
end
