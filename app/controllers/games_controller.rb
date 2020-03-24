class GamesController < ApplicationController
  require 'open-uri'
  skip_before_action :verify_authenticity_token
  def main
  end

  def index
    if !current_user.nil?
      render json: {msg: current_user.base,imgupdate: current_user.imgupdate}
    else
      render json: {msg: 'please log in!'}
    end
  end

  def desktop
    # raise
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

  def upload
    if !current_user.nil?
      basephoto = params['_json']
      image = Cloudinary::Uploader.upload(basephoto)
      file = open(image["url"])
      current_user.photo.attach(io: file, filename: 'base.jpg', content_type: 'image/png')
      current_user.update(imgupdate: false)
    end
  end

  def raid
    if !current_user.nil?
      @enemis = []
      @enemis = User.all
      # @enemis = User.where.not(id: current_user.id).shuffle[0..20]
    end
  end

  def startraid
    id = params['id']
      if !current_user.nil?
        if current_user.raidcount < 2
          if !User.find(id).nil?
            checkwon(User.find(id))
            current_user.raidcount += 1
            current_user.save!
          else
            flash[:notice] = 'invalid user'
            redirect_to games_main_path
          end
        else
          flash[:notice] = 'You have exceeded 2 raids for today :('
          redirect_to games_main_path
        end
      else
      redirect_to new_user_session_path
      end
  end

    private

    def checkwon(enemyuser)
      myuser = [0,0,0,0] # 0 - power , 1 - defense, 2 - range, 3 - hp
      enemy  = [0,0,0,0]
      won = 'You won congratz !'
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
        won = 'You lost try next time !'
      end
      flash[:notice] = won
      redirect_to games_main_path
    end
end
