class Meter < ActiveRecord::Base
  
  belongs_to :model
  validates_presence_of :model, :message => "can't be blank"
  
end
