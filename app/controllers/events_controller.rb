# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :login_user, only: %i[create edit new update destroy]

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees.all.paginate(page: params[:page], per_page: 12)
  end

  def index
    @events = Event.all.paginate(page: params[:page])
    @past_events = Event.past.order(:date).paginate(page: params[:page], per_page: 5)
    @upcoming_events = Event.upcoming.order(:date).paginate(page: params[:page], per_page: 5)
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = 'New event created'
      @event.event_attendees.create(attendee_id: current_user.id)
      redirect_to @event
    else
      render 'new'
    end
  end

  def update
    add_attendee
  end

  def destroy
    Event.find(params[:id]).destroy
    flash[:success] = 'Event deleted successfully'
    redirect_to events_url
  end

  private

  def login_user
    unless logged_in?
      flash[:danger] = 'Please login to create event'
      redirect_to login_url
    end
  end

  def event_params
    params.require(:event).permit(:description, :event_date)
  end

  def attendee_checked?
    params[:event][:event_attendees] == '1'
  end

  def add_attendee
    @event = Event.find(params[:id])
    if current_user.attended_event_ids.include?(@event.id)
      flash[:danger] = 'You are already attending this event'
      redirect_to @event
    elsif @event.event_date < Time.now
      flash[:danger] = 'That event has finished. You can not be added to the attendees.'
      redirect_to @event

    else
      @event.attendees << current_user
      flash[:success] = 'Your name have been added to the guestlist.'
      redirect_to @event
    end
  end
end
