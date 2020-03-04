class UserStructure < ApplicationRecord
  belongs_to :structure
  belongs_to :user
  after_initialize :init

  private

  def init
    self.placed  ||= 0
  end
end
