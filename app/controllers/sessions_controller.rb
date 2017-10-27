class SessionsController < ApplicationController
  before_action :require_log_in, only: [:destroy]
  before_action :require_log_out, only: [:create, :new]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if user.nil?
      flash.now[:errors] = ['Invalid email or password']
      render :new
    else
      login!(user)
      # TODO: replace posts_url to the real homepage url
      redirect_to posts_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
