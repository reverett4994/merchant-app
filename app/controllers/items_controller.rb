class ItemsController < ApplicationController
  require 'json'
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  require 'will_paginate/array'
  WillPaginate.per_page = 5


  # GET /items
  # GET /items.json
  def index

    @search=params[:search]
    @sort=params[:sort]
    if @search
      @items=Item.where('breed LIKE ?','%'+@search)
      if @sort=='price_asc'
        @items=@items.order('price DESC')
      elsif @sort=='price_desc'
        @items=@items.order('price ASC')
      elsif @sort=='age_asc'
        @items=@items.order('age DESC')
      elsif @sort=='age_desc'
        @items=@items.order('age ASC')
      end
      if params[:sort]==nil
        @items = @items.order('created_at DESC')
      end
      if @sort== 'distance'
        @items = @items.order('created_at DESC')
         @items.each do |dog|
           @google=GoogleMapsAPI::DistanceMatrix.calculate([current_user.zip],[dog.zip],{:units=>'imperial'})
           dog.distance= @google.rows[0].elements[0].distance
        end
       @items=@items.sort{|a,b| a.distance.to_i <=> b.distance.to_i}
     end
   else
     if @sort=='price_asc'
       @items=Item.order('price DESC')
     elsif @sort=='price_desc'
       @items=Item.order('price ASC')
     elsif @sort=='age_asc'
       @items=Item.order('age DESC')
     elsif @sort=='age_desc'
       @items=Item.order('age ASC')
     end
     if params[:sort]==nil
       @items = Item.order('created_at DESC')
     end
     if @sort== 'distance'
       @items = Item.order('created_at DESC')
        @items.each do |dog|
          @google=GoogleMapsAPI::DistanceMatrix.calculate([current_user.zip],[dog.zip],{:units=>'imperial'})
          dog.distance= @google.rows[0].elements[0].distance
       end
      @items=@items.sort{|a,b| a.distance.to_i <=> b.distance.to_i}
    end
  end

    @items = @items.paginate(:page => params[:page])
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @comment=Comment.new
    @item_album=ItemAlbum.new
    @comments=Comment.where('ITEM_ID LIKE ?',params[:id])


     if user_signed_in?
       @google=GoogleMapsAPI::DistanceMatrix.calculate([current_user.zip],[@item.zip],{:units=>'imperial'})
       @distance_from_user= @google.rows[0].elements[0].distance
       @location= @google.destination_addresses
       @location=@location[0].gsub(/['""']/,'')
       @location=@location.gsub(/[USA]$/,'')
       @location=@location.gsub(/[USA]$/,'')
       @location=@location.gsub(/[USA]$/,'')
       @location=@location.chop
       @location=@location.chop
     else
       @google=GoogleMapsAPI::DistanceMatrix.calculate(['08620'],[@item.zip],{:units=>'imperial'})

       @location= @google.destination_addresses
       @location=@location[0].gsub(/['""']/,'')
       @location=@location.gsub(/[USA]$/,'')
       @location=@location.gsub(/[USA]$/,'')
       @location=@location.gsub(/[USA]$/,'')
       @location=@location.chop
       @location=@location.chop
    end
  end

  # GET /items/new
  def new
    @item = current_user.items.build
  end

  # GET /items/1/edit
  def edit
    @item_album=ItemAlbum.new
  end
  def editpictures
    @item=Item.find(params[:id])
    @item_album=ItemAlbum.new
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.build(item_params)


    respond_to do |format|
      if @item.save

        format.html { redirect_to edit_pics_path(:id => @item.id), notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }

      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
        if @item.update(item_params)
          format.html { redirect_to @item, notice: 'Item was successfully updated.' }
          format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :price, :des,:image,:breed,:age,:gender,:zip)
    end
end
