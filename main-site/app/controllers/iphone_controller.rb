class IphoneController < ApplicationController
  def index
  end

  def login
  end

  def sigup
  end

  def report
    render :text => "success"
  rescue
    render :text => "failed"
  end

  def about
  end

end
