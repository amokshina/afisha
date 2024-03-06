class EventsController < ApplicationController
  before_action :set_event!, only: %i[show destroy edit update]
  before_action :authorize_event!, except: %i[register]
  before_action :authenticate_user!, only: [:register]
  after_action :verify_authorized, except: %i[register]

  def index
    if params[:past_events].present?
      @events = Event.all.order(event_date: :asc).page(params[:page]).per(16)
    else
      @events = Event.where('event_date > ?', Time.now).order(event_date: :asc).page(params[:page]).per(16)
    end
    # Add sorting functionality with a button (order(created_at: :desc))
  end

  def show
    @comment = @event.comments.build
    @comments = Comment.order(created_at: :desc).where(event: @event).page(params[:page]).per(10)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = t('.success_created')
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = t('.success_updated')
      redirect_to events_path
    else
      render :new
    end
  end

  def destroy
    @event.destroy
    flash[:success] = t('.success_deleted')
    redirect_to events_path
  end

  def register
    @event = Event.find(params[:id])

    if @event.event_date > Time.now
      if @event.available_spots.positive? && !current_user.registered_for?(@event)
        registration = Registration.new(event: @event, user: current_user)
        if registration.save
          @event.num_of_people -= 1
          @event.save
          flash[:success] = t('.success_registered')
        else
          flash[:error] = t('.error_registration_failed')
        end
      elsif current_user.registered_for?(@event)
        flash[:notice] = t('.notice_already_registered')
      else
        flash[:error] = t('.error_no_available_spots')
      end
    else
      flash[:error] = t('.error_past_event_registration')
    end
    redirect_to @event
  end

  def remove_registration
    @event = Event.find(params[:id])
    current_user.events.delete(@event) if current_user.events.include?(@event)
    @event.update(num_of_people: @event.num_of_people + 1)
    flash[:success] = t('.success_removed_from_events')
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :event_type, :place, :num_of_people, :event_date, :description, :image).merge(user_id: current_user.id)
  end

  def set_event!
    @event = Event.find params[:id]

    unless @event
      flash[:error] = t('.error_event_not_found')
      redirect_to root_path
    end
  end

  def authenticate_user!
    redirect_to new_session_path, alert: t('.alert_sign_in') unless user_signed_in?
  end

  def authorize_event!
    authorize(@event || Event)
  end
end
