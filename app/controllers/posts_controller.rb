class PostsController < ApplicationController
    before_action { back_or_root unless logged_in? }

    def create 
        @post = current_user.messages.build(content: params[:post][:content])
        respond_to do |format|
            if @post.save
                format.js  
            end 
        end
    end
end
