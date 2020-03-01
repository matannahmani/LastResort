class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def main
    # binding.pry
  end

  def index
    if !current_user.nil?
      render json: {msg: current_user.base}
    else
      render json: {msg: 'please log in!'}
    end
  end

  def update
    if !current_user.nil?
      ## here should be checking if has structure
      current_user.base << params['base']
      current_user.save!
    else
      render json: {msg: 'please log in!'}
    end
  end

end
