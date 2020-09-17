class ArtworkSharesController < ApplicationController
  def create
    new_share = ArtworkShare.new(artwork_share_params)

    if new_share.save
      render json: new_share
    else
      render json: new_share.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    share = ArtworkShare.find(params[:id])
    share.destroy
    render json: share
  end

  def favorite
    share = ArtworkShare.find(params[:id])
    share.favorite = true
    share.save

    render json: share
  end

  def unfavorite
    share = ArtworkShare.find(params[:id])
    share.favorite = false
    share.save

    render json: share
  end

  private

  def artwork_share_params
    params.require(:artwork_shares).permit(:viewer_id, :artwork_id)
  end
end
