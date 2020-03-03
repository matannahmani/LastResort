class UserStructuresController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def index
    @structures = Structure.all
  end

  def build
    check_resources
  end

  private

  def check_resources
    if !current_user.nil?
          choice = params[:structure].to_sym
          user_resources = current_user.user_resources
          stuctures = idtoname

          if stuctures[choice].nil?
            flash[:alert] = "Try again"
            redirect_to new_user_unit_path
            return
          end
          if !user_resources.where(resource_id: stuctures[choice])[0].nil?
            # binding.pry
            user_stuctures = user_resources.where(resource_id: stuctures[choice])[0].amount
          else
            flash[:alert] = "Sorry, you don't have enough resources"
            redirect_to new_user_unit_path
            return
            # render json: {msg: "Sorry, you don't have enough resources",bought: false}
          end
          # binding.pry
          if stuctures[choice].exchange * 10 <= user_stuctures
            user_minus = user_resources.find_by(resource_id: stuctures[choice].id)
            user_minus.amount -= stuctures[choice].exchange * 10
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
        barrack = Structure.find_by(name: 'barrack')
        wheel = Structure.find_by(name: 'wheel')
        wall = Structure.find_by(name: 'wall')
        boat = Structure.find_by(name: 'boat')
        return {barrack: barrack, wheel: wheel, wall: wall, boat: boat}
      end
  end
end
