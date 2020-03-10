class Friend < ApplicationRecord
  after_initialize :init#,:checkaccept
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  def init
    self.status = false if self.status.nil?
    self.pending = true if self.pending.nil?
  end

  # def checkaccept # not working
  #   case1 = Friend.exists?(sender_id: self.sender_id, receiver_id: self.receiver_id ,status: false,pending: false)
  #   case2 = Friend.exists?(sender_id: self.receiver_id, receiver_id: self.sender_id ,status: false,pending: false)
  #   if case1 && case2
  #     Friend.find_by(sender_id: self.sender_id, receiver_id: self.receiver_id ,status: false,pending: false).destroy
  #     Friend.find_by(sender_id: self.receiver_id, receiver_id: self.sender_id ,status: false,pending: false).destroy
  #   end
  # end

end
