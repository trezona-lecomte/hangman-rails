class Guess < ActiveRecord::Base
  belongs_to :game

  validates :game,   presence: true
  validates :letter, presence: true, inclusion: Game::ALPHABET
end
