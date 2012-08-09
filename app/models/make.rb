class Make < ActiveRecord::Base
  
  has_many :models
  
  scope :active, where(:active => true)
  
end
