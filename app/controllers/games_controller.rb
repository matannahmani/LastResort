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
      user = current_user.user_structures
      list = user.where.not("amount = placed") # check if there is building the has been bought and not placed
      returnlist = []
      list.each do |structure|
        amount = structure.amount - structure.placed
        strname = Structure.find(structure.id).unit_name
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
      structure_id = Structure.find_by(unit_name: params['name']).id
      user_structure = current_user.user_structures.where(id: structure_id)[0]
      user_structure.placed += 1
      user_structure.save!
      current_user.base << params['base']
      current_user.save!
      else
        render json: {msg: 'Invalid data'}
      end
    else
      render json: {msg: 'please log in!'}
    end
  end

end
