class FriendsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if !current_user.nil?
      myfriends = Friend.where(sender: current_user,status: true).or(Friend.where(receiver: current_user,status: true))
      myfriends = formatfriends(myfriends)
      if myfriends.empty?
        render json: {code: 500, msg: 'Friends list empty'}
      else
        render json: {friends: myfriends, code: 200,msg: 'Success index' }
      end
    else
      render json: {code: 500, msg: 'Please login!'}
    end
  end

  def randomfriends
    if !current_user.nil?
      userlist = User.where.not(id: current_user.id)
      userstoshow = []
      countshow = userlist.count - Friend.where(sender: current_user).or(Friend.where(receiver: current_user)).count
      countshow = 5 if countshow > 5
      while userstoshow.length < countshow
        friend = User.where.not(id: current_user.id).sample
        case1 = !Friend.exists?(sender: current_user, receiver: friend,status: false)
        case2 = !Friend.exists?(sender: friend, receiver: current_user,status: false)
        case3 = !userstoshow.include?(friend.protected)
        userstoshow << friend.protected if case1 && case2 && case3
      end
      render json: {code: 200, data: userstoshow}
    else
      render json: {code: 500, msg: 'Please login!'}
    end
  end

  def searchfriend
    if !current_user.nil?
      if params['input'].nil?
        render json: {code: 500, msg: 'Please enter input'}
      elsif current_user.nickname == params['input']
        render json: {code: 500, msg: 'You cannot add yourself as friend'}
      elsif User.search(params['input']).empty?
        render json: {code: 500, msg: 'User not found'}
      else
        reduced = User.search(params['input']).reduce([]) { |a,user| a << user if current_user != user; a}
        reduced = checkifexists(reduced)
        render json: {code: 200, msg: 'Success search', data: reduced[0..4].map {|friend| friend.protected}}
      end
    else
      render json: {code: 500, msg: 'Please login!'}
    end
  end

  def addfriend
    if !current_user.nil?
      if !params['name'].nil?
        if User.exists?(nickname: params['name']) && current_user.nickname != params['name']
          finduserid = User.find_by(nickname: params['name']).id
          myid = current_user.id
          if Friend.exists?(sender_id: myid,receiver_id: finduserid) || Friend.exists?(receiver_id: finduserid,sender_id: myid)
            Friend.exists?(sender_id: myid,receiver_id: finduserid) ?
            friendship = Friend.find_by(sender_id: myid, receiver_id: finduserid) : friendship = Friend.find_by(receiver_id: myid, sender_id: finduserid)
            if (friendship.pending && friendship.sender != current_user)
              friendship.update(pending: false,status: true)
            else
              render json: {code: 500, msg:'Wait friendship', data: 'Wait for user to check your friendship request!'}
            end
              render json: {code: 200, msg:'Success friendship', data: "#{friendship.sender.nickname} you are now friend of #{friendship.receiver.nickname}"}
          else
            friendship = Friend.create(sender_id: myid,receiver_id: finduserid, status:false, pending:true)
            render json: {code: 200, msg:'Success friendship sent', data: "You have successfully sent friend request to #{friendship.receiver.nickname}"}
          end
        end
      end
    else
      render json: {code: 500, msg:'Error'}
    end
  end

  def myfriendrequest
    if !current_user.nil?
      friendrequests = Friend.where(receiver_id: current_user.id, pending: true)
      if friendrequests.empty?
        render json: {code: 500, msg:"No friend requests",data: "No new friend requets"}
      else
        render json: {code: 200, msg: "Success Friendrequests", data: formatfriends(friendrequests)}
      end
    else
    render json: {code: 500, msg: 'Please login!'}
    end
  end

  def acceptfriend
    if !current_user.nil?
      if !params['nickname'].nil? && !params['accept'].nil? &&User.exists?(nickname: params['nickname'])
        friend = User.find_by(nickname: params['nickname'])
        result = params['accept'].downcase == 'true'
        Friend.find_by(sender: friend,receiver: current_user).update(status: result,pending: false)
        render json: {code: 200, msg: 'Success',data: "#{friend.nickname} has been added to your friendlist"}
      else
        render json: {code: 500, msg: 'Wrong Body', data:"SERVER ERROR"}
      end
    else
      render json: {code: 500, msg: 'Please login!'}
    end
  end

  private

  def formatfriends(friends)
    returnfriends = []
    friends.each do |friend|
      (friend.sender != current_user) ? returnfriends << friend.sender.protected : returnfriends << friend.receiver.protected
    end
    return returnfriends
  end

  def checkifexists(friends)
    rejected = friends.reject do |friend|
      case1 = Friend.find_by(sender_id: current_user.id,receiver_id: friend.id,status: true)
      case2 = Friend.find_by(receiver_id: friend.id,sender_id: current_user.id,status: true)
      case3 = Friend.find_by(sender_id: current_user.id,receiver_id: friend.id,pending: true)
      (case1 || case2 || case3)
    end
    return rejected
  end
end
