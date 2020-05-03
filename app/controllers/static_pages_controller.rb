class StaticPagesController < ApplicationController
  before_action :admin_domain, only: [:users,
                                      :confirmation_queue,
                                      :banned_users]

  def welcome
    if logged_in?
      redirect_to("/stream")
    else
      redirect_to("/login")
    end
  end

  def users
    @users = User.all
  end

  def confirmation_queue
    @users = User.where("confirmed = ?", false)
  end

  def best_posts
     @posts = Message.all.order(karma: :desc).take(100)
  end

  def top_users
    @users = User.all.order(karma: :desc).take(100)
  end

  def banned_users
    @users = User.where("banned = ?", true)
  end

  private

  def admin_domain
    redirect_to(root_url) unless logged_in?
    redirect_to(root_url) unless current_user.admin?
  end
end
