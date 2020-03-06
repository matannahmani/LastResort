class UserUnitsController < ApplicationController
  skip_before_action :verify_authenticity_token
  TENROLL = 90
  ONEROLL = 10

  def create
    if current_user.nil?
      # TO DO: render something
      return
    end
    amount = params[:unit_amount].to_i
    @error = nil
    @units = []
    case amount
    when 10
      if checkgems(TENROLL)
        response = []
        10.times do |i|
          result = generate
          unit = Unit.where(rarity: result.downcase).sample
          UserUnit.create(unit_id: unit.id, user_id: current_user.id)
          @units << {
            name: unit.name,
            rarity: unit.rarity,
            attack: unit.attack,
            defense: unit.defense
          }
        end
        current_user.gems -= TENROLL
        current_user.save!
      else
        @error = "Missing: #{(current_user.gems - TENROLL).abs} gems."
      end
    when 1
      if checkgems(ONEROLL)
        result = generate
        unit = Unit.where(rarity: result.downcase).sample
        UserUnit.create(unit: unit, user: current_user)
        current_user.gems -= ONEROLL
        current_user.save!
        @units << {
          name: unit.name,
          rarity: unit.rarity,
          attack: unit.attack,
          defense: unit.defense
        }
      else
        @error = "Missing: #{(current_user.gems - ONEROLL).abs} gems."
      end
    end
    @resources = current_user.resources_amounts
  end

  def new
    @resources = current_user.resources_amounts
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
    (current_user.gems - option) >= 0
  end

end

