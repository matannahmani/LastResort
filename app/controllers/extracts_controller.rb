class StoryController < ApplicationController
  def pick_up
    @longtitude = params[:lng]
    @latitude = params[:lat]
  end
end
