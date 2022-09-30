class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :likes
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        has_many :followed_users,
        foreign_key: :follower_id,
        class_name: 'Relationship',
        dependent:  :destroy

        has_many :followees,through: :followed_users,dependent: :destroy

        has_many :following_users,
        foreign_key: :followee_id,
        class_name:  'Relationship',
        dependent: :destroy

        has_many :followers,through: :following_users, dependent: :destroy
end
