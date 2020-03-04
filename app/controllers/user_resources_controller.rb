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
      exchange_amount = params[:amount].to_i
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
      if exchange_amount <= user_materials
        user_resource = user_resources.find_by(resource_id: materials[choice].id)
        user_resource.amount -= exchange_amount
        user_resource.save!

        gem_amount = exchange_amount / materials[choice].exchange
        current_user.gems += gem_amount
        current_user.save
        flash[:alert] = "Successfully bought #{gem_amount} Gems!"
        redirect_to new_user_unit_path
        # render json: {msg: "Successfully bought 10 Gems!",bought: true}
      else
        flash[:alert] = "Sorry, you don't have enough resources"
        redirect_to new_user_unit_path
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
    gold = Resource.find_by(name: 'gold')
    water = Resource.find_by(name: 'water')
    return {wood: wood, iron: iron, gold: gold, water: water}
  end
end
