class PostsController < ApplicationController
    before_action { back_or_root unless logged_in? }

    def create 
        @post = current_user.messages.build(content: params[:post][:content])
        respond_to do |format|
            if @post.save
                notice_message = "Posted message!"
            else 
                notice_message = "Failed to post message."
            end
            
            format.html 
            format.js   
        end
    end
end
