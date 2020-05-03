module SessionsHelper
    
    def log_in(user)
        session[:user_id] = user.id 
        user.update_attribute(:online, true)
    end

    def log_out(user)
        user ||= current_user
        session.delete(:user_id)
        user.update_attribute(:online, false)
        forget user
    end

    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def forget(user)
        user.forget 
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    def logged_in?
        !current_user.nil?
    end

    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user 
                @current_user = user
            end 
        end
    end
    
end
