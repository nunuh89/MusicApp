class UsersController < ApplicationController
before_action :require_log_out, only: [:create, :new]
# before_action :require_log_in, only: [:update]
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      login_user!(@user)
      # some homepage
      # redirect_to :

    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email,:password)
  end
end
