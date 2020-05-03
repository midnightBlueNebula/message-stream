class SessionsController < ApplicationController
  before_action :check_login, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password]) && !logged_in?
      if user.confirmed?
        log_in user 
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        flash[:success] = "Logged in."
        redirect_to "/profile/#{user.id}"
      else
        flash[:danger] = "Account hasn't been confirmed yet."
        back_or_root
      end
    else
      flash[:danger] = "Failed to log in."
      back_or_root
    end
  end

  def destroy
    log_out current_user if logged_in?
    back_or_root
  end

  private 

  def check_login
    redirect_to(root_url) if logged_in?
  end

end
