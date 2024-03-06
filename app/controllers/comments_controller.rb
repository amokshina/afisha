class CommentsController < ApplicationController
  before_action :set_event!
  before_action :set_comment!, except: :create
  before_action :authorize_comment!
  after_action :verify_authorized
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.event = @event

    if @comment.save
      flash[:success] = t('comments.create.success')
      redirect_to event_path(@event)
    else
      flash[:error] = t('comments.create.error')
      @comments = Comment.order(created_at: :desc).where(event: @event)
      render 'events/show'
    end
  end
  def edit
  end

  def update
    if @comment.update comment_params
      flash[:success] = t('comments.update.success')
      redirect_to event_path(@event, anchor: "comment-#{@comment.id}")
    else
      flash[:error] = t('comments.update.error')
      render :edit
    end
  end
  def destroy
    @comment.destroy
    flash[:success] = t('comments.destroy.success')
    redirect_to event_path(@event)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
  def set_event!
    @event = Event.find params[:event_id]

    unless @event
      flash[:error] = 'Event not found'
      redirect_to root_path
    end
  end
  def set_comment!
    @comment = @event.comments.find params[:id]
  end

  def authorize_comment!
    authorize(@comment || Comment)
  end
end