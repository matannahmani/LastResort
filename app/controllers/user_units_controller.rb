class UserUnitsController < ApplicationController
  skip_before_action :verify_authenticity_token
  TENROLL = 90
  ONEROLL = 10
  def create
    if !current_user.nil?
      option = params[:amount].to_i
          if option == 10 || option == 1
            case option
            when 10
              if checkgems(TENROLL)
                response = []
                10.times do |i|
                  result = generate
                  unit = Unit.where(rarity: result.downcase).sample
                  UserUnit.create(unit_id: unit.id, user_id: current_user.id)
                  response << [unit.name,unit.rarity,unit.attack,unit.defense]
                end
                current_user.gems -= TENROLL
                  current_user.save!
                render json: response
              else
                render json: {error: "not enough gems mising: #{current_user.gems -= TENROLL}"}
              end
            when 1
              if checkgems(ONEROLL)
                result = generate
                unit = Unit.where(rarity: result.downcase).sample.id
                UserUnit.create(unit_id: unit.id, user_id: current_user.id)
                current_user.gems -= ONEROLL
                  current_user.save!
                render json: unit.name
              else
                render json: "not enough gems mising: #{current_user.gems -= ONEROLL}"
              end
            end
          end
    end
  end

  def new
    @resources = Structure.all
  end

  private
  def user_units_params(params)
    params.require(:user_units).permit(:amount)
  end

  def generate
    luck = rand(1..100)
    case luck
    when 1..5
      result = 'SS'
    when 6..16
      result = 'S'
    when 17..37
      result = 'A'
    when 38..100
      result = 'B'
    end
  end

  def checkgems(option)
    (current_user.gems -= option) >= 0
  end

end
