class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  validates :hidden_word, presence: true
  validates :username, presence: true

  enum status: [:in_progress, :won, :lost]

  def initialize(username: "anonymous", hidden_word: "magic")
    super
    @username = username
    @hidden_word = hidden_word
  end
end
