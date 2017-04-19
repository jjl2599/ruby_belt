class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new,:create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]
  def new
    @ideas = Idea.all
    @current_user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.save
      session[:user_id] = @user.id
      redirect_to "/ideas"
    else
      flash[:registration_errors] = @user.errors.full_messages
      redirect_to "/"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      reset_session
      redirect_to "/users/new"
    else
      redirect_to "/users/#{@user.id}/edit"
    end
  end


  def show
    @user = User.find(params[:id])
  end


  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      reset_session
      redirect_to "/users/new"
    else
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  private
  def require_correct_user
    if current_user != User.find(params[:id])
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  def user_params
    params.require(:user).permit(:name, :alias,:email, :password, :password_confirmation)
  end
end
