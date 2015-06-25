class Guess < ActiveRecord::Base
  belongs_to :game

  validates :letter, presence: true, inclusion: Game::ALPHABET
  validates :game, presence: true
end
