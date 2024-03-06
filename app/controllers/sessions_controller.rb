class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      sign_in(user)
      flash[:success] = t('.success_welcome_back')
      redirect_to root_path
    else
      flash.now[:warning] = t('.error_incorrect_credentials')
      render :new
    end
  end

  def destroy
    sign_out
    flash[:success] = t('.success_logged_out')
    redirect_to root_path
  end
end
