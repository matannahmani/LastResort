class UserResourcesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def index
    @user_resources = UsersController.all
  end

  def update
  end

  def exchange
    checkfunds
  end

  private
  def checkfunds
    if !current_user.nil?
      choice = params[:material].to_sym
      user_resources = current_user.user_resources
      materials = idtoname

      if materials[choice].nil?
        flash[:alert] = "Try again"
        redirect_to new_user_unit_path
        return
      end
      if !user_resources.where(resource_id: materials[choice])[0].nil?
        # binding.pry
        user_materials = user_resources.where(resource_id: materials[choice])[0].amount
      else
        flash[:alert] = "Sorry, you don't have enough resources"
        redirect_to new_user_unit_path
        return
        # render json: {msg: "Sorry, you don't have enough resources",bought: false}
      end
      # binding.pry
      if materials[choice].exchange * 10 <= user_materials
        user_minus = user_resources.find_by(resource_id: materials[choice].id)
        user_minus.amount -= materials[choice].exchange * 10
        user_minus.save!

        flash[:alert] = "Successfully bought 10 Gems!"
        redirect_to new_user_unit_path
        # render json: {msg: "Successfully bought 10 Gems!",bought: true}
      else
        redirect_to new_user_session_path
        # render json: {msg: "Please log in!",bought: false}
      end
    end
  end

  def buystructures
    if !current_user.nil?
    else
      render json: {msg: "Please log in!"}
    end
  end


  def idtoname
    wood = Resource.find_by(name: 'wood')
    iron = Resource.find_by(name: 'iron')
    metal = Resource.find_by(name: 'metal')
    water = Resource.find_by(name: 'water')
    return {wood: wood, iron: iron,metal: metal,water: water}
  end
end
