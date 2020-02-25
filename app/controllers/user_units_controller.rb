class UserUnitsController < ApplicationController
  def create
    # check if buy one or buy 5
    # randomize units
    # current_user

    _json = JSON.parse(params['user_units'])
    params = _json.except('amount')

    params['user_id'] = current_user.id


    amount = _json['amount'].to_i

    amount.times do |i|
      params['unit_id'] = Unit.all.sample.id
      user_unit = UserUnit.new(params)
      user_unit.save
    end
  end

  def new

  end

  private

  def user_units_params(params)
    params.require(:user_units).permit(:user_id, :unit_id)
  end
end
