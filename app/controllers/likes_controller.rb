class LikesController < ApplicationController
    before_action { back_or_root unless logged_in? }
    
    def like 
        like_menager("like")
    end

    def dislike 
        like_menager("dislike")
    end 

    private 

    def like_menager(role="like")
        @post = Message.find_by(id: params[role.to_sym][:post_id])
        back_or_root if @post.nil?
        respond_to do |f|
            if role == "dislike"
                if !get_like.empty?
                    get_like.delete_all
                    reduce_point
                elsif get_dislike.empty?
                    create_dislike
                end
            else
                if !get_dislike.empty?
                    get_dislike.delete_all
                    add_point
                elsif get_like.empty?
                    create_like
                end
            end 
            f.js    
        end
    end

    def get_like
        Like.where("user_id = ? AND message_id = ?", current_user.id, @post.id)
    end

    def get_dislike
        Dislike.where("user_id = ? AND message_id = ?", current_user.id, @post.id)
    end

    def create_like
        if Like.new(user_id: current_user.id, message_id: @post.id).save
            add_point
        end
    end

    def create_dislike
        if Dislike.new(user_id: current_user.id, message_id: @post.id).save
            reduce_point
        end
    end

    def add_point
        @post.user.update_attribute(:karma, current_user.karma+1)
        @post.update_attribute(:karma, @post.karma+1)
    end

    def reduce_point
        @post.user.update_attribute(:karma, current_user.karma-1)
        @post.update_attribute(:karma, @post.karma-1)
    end
end
