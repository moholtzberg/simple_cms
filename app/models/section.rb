require "lib/assets/position_mover"
class Section < ActiveRecord::Base
  
  include PositionMover
  
  belongs_to :page
  has_many :section_edits 
  has_many :editors, :through => :section_edits, :class_name => "AdminUser"
  
  CONTENT_TYPES = ["Text", "Html"]
  
  validates_presence_of :name
  validates_length_of :name, :within => 3..32
  
  validates_presence_of :page_id
  
  validates_inclusion_of :content_type, :in => CONTENT_TYPES, :message => "must be one of the following types #{CONTENT_TYPES.join[', ']}"
  
  scope :sorted, order(:position, :name, :page_id)
  
  private
  
  def position_scope
    "sections.page_id = #{page_id.to_i}"
  end
  
end
