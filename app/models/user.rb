class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_resources
  has_many :user_units
  validates :nickname, uniqueness: true
  # validates :gems, numericality: { greater_than_or_equal_to: 0 }
end
