# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    query = request.query_parameters

    if query.key?(:username)
      render json: User.where('username LIKE ?', query[:username].to_s)
    else
      render json: User.all
    end
  end

  def create
    new_user = User.new(user_params)

    if new_user.save
      render json: new_user
    else
      render json: new_user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    user = User.find(params[:id])

    render json: user
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: user
  end

  def favorites
    user = User.find(params[:user_id])
    user_favorites = user.favorite_artworks + user.favorite_shared_artworks

    render json: user_favorites
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
