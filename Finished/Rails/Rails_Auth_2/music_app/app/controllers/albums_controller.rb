class AlbumsController < ApplicationController
  before_action :require_user!
  before_action :require_admin!, except: :show

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def new
    @album = Album.new(band_id: params[:band_id])
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to new_band_album_url(@album.band_id)
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to edit_album_url(@album)
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band_id)
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :title, :year, :live)
  end
end
