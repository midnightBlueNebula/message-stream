module ApplicationHelper

    def back_or_root
        redirect_back(fallback_location: root_url)
    end
    
end
