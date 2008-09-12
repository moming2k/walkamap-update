class Region < ActiveRecord::Base
  def location
    return "NIL" if read_attribute(:location).blank? 
    return read_attribute(:location)
  end
end
