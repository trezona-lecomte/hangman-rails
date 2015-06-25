class Guess < ActiveRecord::Base
  belongs_to :game

  validates :letter, presence: true
  validates :game, presence: true
end
