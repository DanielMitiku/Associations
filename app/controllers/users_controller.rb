class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
@user = User.new(user_params)    
    if @user.save
    flash[:success] = "Welcome to the Private Events website!"
    log_in(@user)
    redirect_to @user

    
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
   
    @created_events =  @user.events
    @attended_events  = @user.attended_events

    @upcoming_created_events = @created_events.upcoming.order(:date)
    @past_created_events = @created_events.past.order(:date)

    @upcoming_attending_events = @attended_events.upcoming.order(:date)
    @past_attending_events = @attended_events.past.order(:date)
    
  end

private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
