class GamesController < ApplicationController
  def index
    @base = current_user.base
  end

  def update
  end

end
