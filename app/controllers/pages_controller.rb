class PagesController < ApplicationController
  def index
    if user_signed_in?
      if params[:past_events].present?
        @user_events = current_user.events.order(event_date: :asc)
      else
        @user_events = current_user.events.where('event_date > ?', Time.now).order(event_date: :asc)
      end
    else
      @events = Event.all
    end
  end
end

