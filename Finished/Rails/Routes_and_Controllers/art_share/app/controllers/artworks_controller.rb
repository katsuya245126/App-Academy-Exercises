class ArtworksController < ApplicationController
  def index
    if params[:user_id]
      user_artworks = Artwork.where(artist_id: params[:user_id])
      shared_artworks = User.find(params[:user_id]).shared_artworks
      render json: user_artworks + shared_artworks
    elsif params[:collection_id]
      collection_artworks = Collection.find(params[:collection_id]).artworks
      render json: collection_artworks
    end
  end

  def create
    new_artwork = Artwork.new(artwork_params)

    if new_artwork.save
      render json: new_artwork
    else
      render json: new_artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    artwork = Artwork.find(params[:id])

    render json: artwork
  end

  def update
    artwork = Artwork.find(params[:id])

    if artwork.update(artwork_params)
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])
    artwork.destroy
    render json: artwork
  end

  def like
    new_like = Like.new(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Artwork')

    if new_like.save
      render json: new_like
    else
      render json: new_like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def unlike
    like = Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: 'Artwork')

    if like.destroy
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def favorite
    artwork = Artwork.find_by(id: params[:id], artist_id: params[:user_id])
    artwork.favorite = true
    artwork.save
    render json: artwork
  end

  def unfavorite
    artwork = Artwork.find_by(id: params[:id], artist_id: params[:user_id])
    artwork.favorite = false
    artwork.save
    render json: artwork
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end
