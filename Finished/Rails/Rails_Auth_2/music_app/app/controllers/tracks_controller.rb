class TracksController < ApplicationController
  before_action :require_user!
  before_action :require_admin!, except: :show

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def new
    @track = Track.new(album_id: params[:album_id])
    render :new
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to new_album_track_url(@track.album_id)
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to edit_track_url(@track)
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to album_url(@track.album_id)
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :title, :ord, :lyrics, :bonus)
  end
end
