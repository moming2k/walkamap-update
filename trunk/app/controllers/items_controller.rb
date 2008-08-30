class ItemsController < ApplicationController
  in_place_edit_for :item, :address 
  in_place_edit_for :item, :name 
  in_place_edit_for :item, :tel 
  protect_from_forgery :only => [:update, :delete, :create]
  # GET /items
  # GET /items.xml
  def index
    @filter_checked = params[:filter_checked] || session[:filter_checked] || false
    session[:page] = params[:page] || session[:page]
    session[:filter_checked] = @filter_checked
    
    @conditions = ["is_checked =?",@filter_checked]
    
    @items = Item.paginate(:page => session[:page], :conditions => @conditions, :order => "lat desc, lng desc")
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end
  
  def set_filter
    
  end
  
  def search
    @keyword = params[:keyword] || session[:keyword]
    @filter_checked = params[:filter_checked] || session[:filter_checked] || false
    session[:keyword] = @keyword
    session[:filter_checked] = @filter_checked
    @items = Item.paginate :page => params[:page], :conditions => ["name Like ? or address Like ? or id = ? or tel Like ?","%#{@keyword}\%","%#{@keyword}\%",@keyword ,"%#{@keyword}\%"],:order => "lat desc, lng desc"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
end
