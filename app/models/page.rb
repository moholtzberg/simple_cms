class Page < ActiveRecord::Base
  
  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  
  validates_presence_of :name
  validates_length_of :name, :within => 3..32
  
  validates_presence_of :subject_id
  
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..32
  validates_uniqueness_of :permalink, :scope => :subject_id
  
  scope :sorted, order(:position, :name, :permalink)
  
end
