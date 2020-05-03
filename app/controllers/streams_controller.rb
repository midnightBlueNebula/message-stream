class StreamsController < ApplicationController

  def show
    @stream = Message.where("created_at > ?", 5.minutes.ago)
              .order(created_at: :desc)

    respond_to do |format|
      format.html { render :show }
      format.js   
    end
  end
  
end
