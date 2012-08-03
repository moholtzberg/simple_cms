#require "digest/sha1"

class AdminUser < ActiveRecord::Base
  
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections , :through => :section_edits
  
  validates_presence_of :first_name
  validates_length_of :first_name, :within => 3..32
  
  validates_presence_of :last_name
  validates_length_of :last_name, :within => 3..32
  
  validates_presence_of :username
  validates_length_of :username, :within => 8..32
  validates_uniqueness_of :username
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  validates_presence_of :email
  validates_length_of :email, :within => 8..32
  # validates_format_of :email => EMAIL_REGEX
  validates_uniqueness_of :email
  validates_confirmation_of :email
  
  attr_accessor :password
  unless :password.blank?
    validates_length_of :password, :within => 8..32
  end
  
  before_save :create_hashed_password
  after_save :clear_password
  
  scope :named, lambda {|first, last| where(:first_name => first, :last_name => last)}
  
  attr_protected :hashed_password, :salt
  
  def self.authenticate(username="", password="")
    user = AdminUser.find_by_username(username)
    if user && user.password_match?(password)
      return user
    else
      return false  
    end
  end
  
  def password_match?(password="")
    hashed_password == AdminUser.hash(password, salt)
  end
  
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Use #{username} with #{Time.now} to make some salt and pepper")
  end
  
  def self.hash(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password} for taste")
  end
  
  private
  
  def create_hashed_password
    unless password.blank?
      puts "$$$$$ 1 #{password} $$$$$"
      self.salt = AdminUser.make_salt(username) if salt.blank?
      puts "$$$$$ 2 #{salt} $$$$$"
      self.hashed_password = AdminUser.hash(password, salt)
      puts "$$$$$ 3 #{hashed_password} $$$$$"
    end
  end
  
  def clear_password
    self.password = nil
  end
  
end