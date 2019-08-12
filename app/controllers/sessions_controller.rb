class SessionsController < ApplicationController
  def new
   
  end

  def create
 user = User.find_by(id: params[:session][:id])
    if user#j && user.authenticate(params[:session][:password])
      log_in user
#      remember user
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid id'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path

  end
end
