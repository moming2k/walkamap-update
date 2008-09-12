class Item < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 50
  
  acts_as_soft_deletable
  validates_presence_of :name
  validates_presence_of :address
  
  def self.find_checked(checked, *args)
    with_scope :find => { :conditions => [ 'is_checked = ?', checked ] } do
      find(:all,*args)
    end
  end
  
  def tel
    return "NIL" if read_attribute(:tel).blank? 
    return read_attribute(:tel)
  end
  
  def tel=(value)
    if value == "NIL"
      write_attribute(:tel,"") 
    else
      write_attribute(:tel,value) 
    end
  end
end
