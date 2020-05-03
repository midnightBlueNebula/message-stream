class ConfirmationsController < ApplicationController
    before_action { redirect_to(root_url) unless current_user.admin? }

    def confirm
        @user = User.find(params[:user][:id])
        back_or_root unless !@user.confirmed?
        @user.update_attribute(:confirmed, true)
        respond_to do |f|
            f.html { redirect_to('/confirmation_queue') }
            f.js
        end
    end
end
