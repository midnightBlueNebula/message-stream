class LikesController < ApplicationController
    before_action { back_or_root unless logged_in? }
    
    def like 
        like_menager
    end

    def dislike 
        like_menager("dislike")
    end 

    private 

    def like_menager(role="like")
        @post = Message.find_by(id: params[role.to_sym][:post_id])
        back_or_root if @post.created_at < 5.minutes.ago || @post.nil?
        respond_to do |f|
            notice_message = ""
            change = 0
            if Like.where(user_id: current_user.id, message_id: @post.id).exists? || Dislike.where(user_id: current_user.id, message_id: @post.id).exists?
                flash[:warning] = "You've already voted for this message."
                back_or_root
            else 
                if role == "like" 
                    if Like.new(user_id: current_user.id, message_id: @post.id).save 
                        change = 1
                        notice_message = "Liked!"
                    else
                        notice_message = "Error!"
                    end
                else 
                    if Dislike.new(user_id: current_user.id, message_id: @post.id).save 
                        change = -1
                        notice_message = "Disliked!"
                    else
                        notice_message = "Error!"
                    end
                end 
                @post.update_attribute(:karma, @post.karma+change)
                current_user.update_attribute(:karma, current_user.karma+change)
            end 
            f.html { redirect_to "/stream" }
            f.js   
        end
    end
end
