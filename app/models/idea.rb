class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  validates :idea, presence: true
  validates :user, presence: true
end
