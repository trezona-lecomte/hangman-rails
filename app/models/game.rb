class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  STATES = ["In Progress", "Won", "Lost"]

  validates :status, inclusion: { in: STATES, message: "'%{value}' is not a valid status" }
  validates :hidden_word, presence: true
  validates :username, presence: true

  def initialize(username: "anonymous", hidden_word: "magic")
    super
    @username = username
    @hidden_word = hidden_word
    @status = "In Progress"
  end
end
