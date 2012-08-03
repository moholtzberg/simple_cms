class Subject < ActiveRecord::Base
  
  has_many :pages
  
  validates_presence_of :name
  validates_length_of :name, :within => 3..32
  
end
