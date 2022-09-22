class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable # ,  :validatable

  has_many :albums

  validates :full_name, :username, :role, presence: true
  validates :username, uniqueness: true
  validates :role, inclusion: { in: ['admin', 'user'] }
end
