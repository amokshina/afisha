module Admin
  class Admin::UsersController < Admin::BaseController
    before_action :require_authentication
    before_action :set_user!, only: %i[edit update destroy]
    before_action :authorize_user!
    after_action :verify_authorized
    def index
      @users = User.all.order(created_at: :desc).page(params[:page]).per(16)
    end
    def edit
    end
    def update
      if @user.update user_params
        flash[:success] = 'User updated'
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      flash[:success] = 'User deleted'
      redirect_to admin_users_path
    end

    private
    def set_user!
      @user = User.find params[:id]
    end
    def user_params
      params.require(:user).permit(:email, :username, :usersurname, :role,
                                   :password, :password_confirmation)
    end
    def authorize_user!
      authorize(@user || User)
    end
  end
  end