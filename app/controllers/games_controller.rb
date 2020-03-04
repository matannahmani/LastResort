class GamesController < ApplicationController
  require 'open-uri'
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
      userstr = current_user.user_structures.where(id: structure_id)[0]
      if userstr.amount > userstr.placed
        user_structure = current_user.user_structures.where(id: structure_id)[0]
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

  def upload
    if !current_user.nil?

      basephoto = params['_json']
      image = Cloudinary::Uploader.upload(basephoto)
      file = open(image["url"])
      current_user.photo.attach(io: file, filename: 'base.jpg', content_type: 'image/png')
    end
  end
  def raid
    if !current_user.nil?
      @enemis = []
      while @enemis.length != 2
        sample = User.all.sample
          @enemis << sample if !(@enemis.include?(sample))
      end
    end
  end

  def startraid
    id = params['id']
      if !current_user.nil?
        if current_user.raidcount < 2
          if !User.find(id).nil?
            checkwon(User.find(id))
          else
            redirect_to games_main_path
          end
        end
      else
      redirect_to new_user_session_path
      end
  end

    private

    def checkwon(enemyuser)
      myuser = [0,0,0,0] # 0 - power , 1 - defense, 2 - range, 3 - hp
      enemy  = [0,0,0,0]
      current_user.user_units.each do |myunit|
        myuser[0] += myunit.unit.attack
        myuser[1] += myunit.unit.defense
        myuser[2] += myunit.unit.range
        myuser[3] += myunit.unit.hp
      end
      enemyuser.user_units.each do |myunit|
        enemy[0] += myunit.unit.attack
        enemy[1] += myunit.unit.defense
        enemy[2] += myunit.unit.range
        enemy[3] += myunit.unit.hp
      end
      if myuser.inject(:+) > enemy.inject(:+)
        amount = current_user.user_resources.first.amount
        amountsecond = current_user.user_resources.second.amount
        current_user.user_resources.first.update(amount: (amount += 20))
        current_user.user_resources.second.update(amount: (amount += 20))
      else
        amount = current_user.user_resources.first.amount
        amountsecond = current_user.user_resources.second.amount
        enemyuser.user_resources.first.update(amount: (amount += 20))
        enemyuser.user_resources.second.update(amount: (amount += 20))
      end
      redirect_to games_main_path
    end
end
