class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(name: params[:name])
    if !@user.nil? && @user.password_hash == params[:password]
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
    else
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
