class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  enum status: [:in_progress, :won, :lost]
  ALPHABET = %w{ a b c d e f g h i j k l m n o p q r s t u v w x y z }

  validates :hidden_word, presence: true
  validates :username, presence: true

  def initialize(username: "anonymous", hidden_word: "magic")
    super
    @username = username
    @hidden_word = hidden_word
  end

  def unguessed_letters
    # TODO: zip on ALPHABET and @guesses.letters to get the diff
  end
end
