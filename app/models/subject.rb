require "lib/position_mover"
class Subject < ActiveRecord::Base
  
  include PositionMover
  
  has_many :pages
  
  validates_presence_of :name
  validates_length_of :name, :within => 3..32
  
  scope :visible, where(:visable => true)
  scope :sorted, order(:position)
  
end
