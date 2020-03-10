class FriendsController < ApplicationController
  def index
    if !current_user.nil?
      myfriends = Friend.where(sender: current_user,status: true).or(Friend.where(receiver: current_user,status: true))
      myfriends = formatfriends(myfriends)
      if myfriends.empty?
        render json: {code: 500, msg: 'Friends list empty'}
      else
        render json: {friends: myfriends, code: 200 }
      end
    else
      render json: {code: 500, msg: 'Please login!'}
    end
  end

  def randomfriends
    if !current_user.nil?
      userlist = User.where.not(id: current_user.id)
      myfriends = Friend.where(sender_id: 1).or(Friend.where(receiver_id: 1))
      userstoshow = []
      while userstoshow.length < 2
        friend = User.where.not(id: current_user.id).sample
        userstoshow << friend if !Friend.exists?(sender: current_user, receiver: friend) || !Friend.exists?(sender: friend, receiver: current_user)
      end
      render json: {code: 200, friend: userstoshow}
    else
      render json: {code: 500, msg: 'Please login!'}
    end
  end

  def show
    @user = User.all
  end

  private

  def formatfriends(friends)
    returnfriends = []
    friends.each do |friend|
      (friend.sender != current_user) ? returnfriends << friend.sender.protected : returnfriends << friend.receiver.protected
    end
    return returnfriends
  end
end
