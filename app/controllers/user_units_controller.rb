class UserUnitsController < ApplicationController
  def create
    @user_unit = UserUnit.create(user_units_params)
    @user_unit.save
  end

  private

  def user_units_params
    params.require(:user_units).permit(:user_id, :unit_id)
  end
end
