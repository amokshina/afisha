class UsersController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[edit update]
  before_action :set_user!, only: %i[edit update]
  before_action :authorize_user!
  after_action :verify_authorized

  def new
    @user = User.new
  end

  def create
    authorize :user
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = t('.account_created')
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = t('.profile_changed')
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  private

  def set_user!
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :usersurname, :email, :password, :password_confirmation)
  end

  def authorize_user!
    authorize(@user || User)
  end
end
