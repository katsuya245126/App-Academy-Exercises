class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:username], params[:password])

    if user.nil?
      flash[:error] = 'Wrong username and/or password'
      redirect_to new_session_url
    else
      login_user!(user)
      redirect_to cats_url
    end
  end

  def destroy
    logout_user!
    redirect_to cats_url
  end

  private

  def session_params
    params.permit(:username, :password)
  end
end
