class IphoneController < ApplicationController
  skip_before_filter :login_required
  
  def index
  end

  def login
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

end
