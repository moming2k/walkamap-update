class SubRegionsController < ApplicationController
  # GET /sub_regions
  # GET /sub_regions.xml
  def index
    @sub_regions = SubRegion.find(:all ,:order => "name")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sub_regions }
    end
  end

  # GET /sub_regions/1
  # GET /sub_regions/1.xml
  def show
    @sub_region = SubRegion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sub_region }
    end
  end

  # GET /sub_regions/new
  # GET /sub_regions/new.xml
  def new
    @sub_region = SubRegion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sub_region }
    end
  end

  # GET /sub_regions/1/edit
  def edit
    @sub_region = SubRegion.find(params[:id])
  end

  # POST /sub_regions
  # POST /sub_regions.xml
  def create
    @sub_region = SubRegion.new(params[:sub_region])

    respond_to do |format|
      if @sub_region.save
        flash[:notice] = 'SubRegion was successfully created.'
        format.html { redirect_to(@sub_region) }
        format.xml  { render :xml => @sub_region, :status => :created, :location => @sub_region }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sub_region.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sub_regions/1
  # PUT /sub_regions/1.xml
  def update
    @sub_region = SubRegion.find(params[:id])

    respond_to do |format|
      if @sub_region.update_attributes(params[:sub_region])
        flash[:notice] = 'SubRegion was successfully updated.'
        format.html { redirect_to(@sub_region) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sub_region.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_regions/1
  # DELETE /sub_regions/1.xml
  def destroy
    @sub_region = SubRegion.find(params[:id])
    @sub_region.destroy

    respond_to do |format|
      format.html { redirect_to(sub_regions_url) }
      format.xml  { head :ok }
    end
  end
end
