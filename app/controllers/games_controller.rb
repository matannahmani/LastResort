class GamesController < ApplicationController
  def index
    @base = current_user.base
  end

  def update
    new_base = params[:base] # to be changed later
    current_user.base = new_base
    current_user.save

    render json: {base: new_base}
  end

end
