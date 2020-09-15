class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
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
    user.update(user_params)
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
