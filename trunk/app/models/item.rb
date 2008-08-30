class Item < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 50
  
  def self.find_checked(checked, *args)
    with_scope :find => { :conditions => [ 'is_checked = ?', checked ] } do
      find(:all,*args)
    end
  end
end
