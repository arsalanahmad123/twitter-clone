class Tweet < ApplicationRecord
    belongs_to :user
    validates :tweet, presence: true
    acts_as_votable
    has_many :likes
end
