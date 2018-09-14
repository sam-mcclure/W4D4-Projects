class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
    @band = Band.find_by(id: @album.band_id)
    render :show
  end

  def new
    @album = Album.new(band_id: params[:band_id])
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @band = Band.find_by(id: @album.band_id)
    @album.destroy
    redirect_to band_url(@band)
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :year, :studio, :band_id)
  end

end
