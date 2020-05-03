class ProfilesController < ApplicationController
  before_action :only_users, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  private

  def only_users
    redirect_to(root_url) unless logged_in?
  end

end
