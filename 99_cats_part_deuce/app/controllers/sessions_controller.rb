class SessionsController < ApplicationController

  before_action :already_logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials( params[:user][:user_name], params[:user][:password] )

    if @user
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = ['you done messed up your username or password!!!!!']
      @user = User.new(user_name: params[:user][:user_name])
      render :new
    end

  end
  
  def destroy
    logout!
    redirect_to new_session_url
  end
end