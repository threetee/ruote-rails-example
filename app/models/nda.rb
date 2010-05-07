class Nda < ActiveRecord::Base
  attr_accessible :name, :attachment
  
  has_many :emails
  
  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
