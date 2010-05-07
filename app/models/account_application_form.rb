class AccountApplicationForm < ActiveRecord::Base
  attr_accessible :name
  
  has_many :emails
end
