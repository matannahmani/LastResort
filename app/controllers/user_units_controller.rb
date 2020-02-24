class UserUnitsController < ApplicationController
  def create
    # check if buy one or buy 5
    # randomize units

    @user_unit = UserUnit.create(user_units_params)
    @user_unit.save
  end

  def new

  end

  private

  def user_units_params
    params.require(:user_units).permit(:user_id, :unit_id)
  end
end
