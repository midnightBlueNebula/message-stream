class RegistrationsController < ApplicationController
  before_action { redirect_to(root_url) if logged_in? }
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Account created! Please wait for confirmation."
      redirect_to "/stream"
    else
      flash[:danger] = "Failed to create account."
      back_or_root
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end

end
