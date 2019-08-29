class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
@user = User.new(user_params)    # Not the final implementation!
    if @user.save
    flash[:success] = "Welcome to the Private Events website!"
    log_in(@user)
    redirect_to @user

      # Handle a successful save.
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
   
    @created_events =  @user.events
    @attended_events  = @user.attended_events
    #@upcoming_created_events = upcoming_created_events @user
    #@past_created_events = past_created_events @user
    #@upcoming_attended_events = upcoming_attended_events @user 
    #@past_attended_events = past_attended_events @user
   
  end

private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
