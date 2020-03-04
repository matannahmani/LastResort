class UserStructure < ApplicationRecord
  after_initialize :init
  belongs_to :structure
  belongs_to :user

  private
  def init
    self.placed  ||= 0           #will set the default value only if it's nil
  end
end
