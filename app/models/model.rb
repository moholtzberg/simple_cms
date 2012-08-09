class Model < ActiveRecord::Base
  
  belongs_to :make
  has_many :meters
  
  before_save :make_metered
  before_save :make_description
  
  scope :active, where(:active => true)
  scope :metered, where(:metered => true)
  scope :color, joins(:meters).where('meters.is_color = ?', 'true')
  
  # attr_protected :metered
  
  def make_metered
    meter = Meter.find_by_model_id(self.id)
    unless meter.nil?
      puts "#{meter.inspect}"
      self.metered = 1
    else
      puts "bye"
      self.metered = 0
    end
  end
  
  def make_description
    if description.nil?
      self.description = "#{self.make.code}-#{self.name}"
    end
  end
  
end