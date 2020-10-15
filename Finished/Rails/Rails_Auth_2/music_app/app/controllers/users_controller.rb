class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.verification_email(@user).deliver_now!
      flash[:notifications] = ['Sign up successful! Check your inbox for the verification email.']
      redirect_to new_session_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    render :show
  end

  def verify
    user = User.find_by(verification_token: params[:verification_token])
    user.verify!
    flash[:notifications] = ['You have successfully verified your account! You can log in now.']
    redirect_to new_session_url
  end

  def admin
    user = User.find(params[:id])
    user.make_admin!
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
