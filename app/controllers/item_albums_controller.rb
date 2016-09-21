class ItemAlbumsController < ApplicationController
  before_action :set_item_album, only: [:show, :edit, :update, :destroy]

  # GET /item_albums
  # GET /item_albums.json
  def index
    @item_albums = ItemAlbum.all
  end

  # GET /item_albums/1
  # GET /item_albums/1.json
  def show
  end

  # GET /item_albums/new
  def new
    @item_album = ItemAlbum.new
  end

  # GET /item_albums/1/edit
  def edit
  end

  # POST /item_albums
  # POST /item_albums.json
  def create
    @item_album = ItemAlbum.new(item_album_params)
    @item_album.item_id=params[:item]
    respond_to do |format|
      if @item_album.save
        format.html { redirect_to item_path(params[:item]), notice: 'Item album was successfully created.' }
        format.json { render :show, status: :created, location: @item_album }
      else
        format.html { render :new }
        format.json { render json: @item_album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_albums/1
  # PATCH/PUT /item_albums/1.json
  def update
    respond_to do |format|
      if @item_album.update(item_album_params)
        format.html { redirect_to @item_album, notice: 'Item album was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_album }
      else
        format.html { render :edit }
        format.json { render json: @item_album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_albums/1
  # DELETE /item_albums/1.json
  def destroy
    @item_album.destroy
    respond_to do |format|
      format.html { redirect_to item_albums_url, notice: 'Item album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_album
      @item_album = ItemAlbum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_album_params
      params.require(:item_album).permit(:item_id,:image)
    end
end
