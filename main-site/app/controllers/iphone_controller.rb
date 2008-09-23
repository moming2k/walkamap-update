class IphoneController < ApplicationController
  skip_before_filter :login_required
  
  def index
  end

  def login
  end
  
  def getID
    temp_id = Time.now.strftime("%H%m%S") + UUID.timestamp_create.to_s[0..7]
    render :text => temp_id
  end
  
  def logout
    
  end

  def signup
  end

  def report
    render :text => "success"
  rescue
    render :text => "failed"
  end

  def about
  end
  
  private
  def allow_to
    super :all, :all => true
    # super :admin, :all => true
    # super :user, :only => [:new, :create]
  end

end
