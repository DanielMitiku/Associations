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
   
    @events = @user.events.paginate(page: params[:page])
    @past_events = Event.past.order(:date).paginate(page: params[:page], per_page: 5)
		@upcoming_events = Event.upcoming.order(:date).paginate(page: params[:page], per_page: 5)
  end

private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
