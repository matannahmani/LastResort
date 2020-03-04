class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def main
  end

  def index
    if !current_user.nil?
      render json: {msg: current_user.base}
    else
      render json: {msg: 'please log in!'}
    end
  end

  def getupdate
    if !current_user.nil?
      user_structures = current_user.user_structures
      unplaced = user_structures.where.not("amount = placed") # check if there is building the has been bought and not placed
      returnlist = []
      unplaced.each do |user_structure|
        amount = user_structure.amount - user_structure.placed
        strname = user_structure.structure.unit_name
        returnlist << {strname => amount}
      end
      (returnlist.count.zero?) ? (render json: {result: false}) : (render json: {msg: returnlist, result: true})
    else
      render json: {msg: 'please log in!', result: false}
    end
  end

  def update
    if !current_user.nil?
      ## here should be checking if has structure
      if !params['base'].nil? && (params['base'].match? (/layer3.putTilesAt\(buildings_type\['.+'\],\d+,\d+\);/))
      structure = Structure.find_by(unit_name: params['name'])
      user_structure = current_user.user_structures.find_by(structure: structure)
      if user_structure.amount > user_structure.placed
        user_structure.placed += 1
        user_structure.save!
        current_user.base << params['base']
        current_user.save!
        render json: {error: '200'}
      else
        render json: {msg: 'you dont have this structure',error: '501'}
      end
      else
        render json: {msg: 'Invalid data'}
      end
    else
      render json: {msg: 'please log in!'}
    end
  end

end
