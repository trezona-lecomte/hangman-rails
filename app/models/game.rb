class Game < ActiveRecord::Base
  has_many :guesses,
            dependent: :destroy

  enum status: [:in_progress, :won, :lost]

  ALPHABET = ("a".."z").to_a

  validates :hidden_word, :username, :lives, presence: true

  def unguessed_letters_of_alphabet
    ALPHABET.reject { |l| guesses.any? { |g| g.letter == l } }
  end

  def obfuscated_letters(mask_character)
    hidden_word.chars.map do |letter|
      guesses.any? { |g| g.letter == letter } ? letter : mask_character
    end
  end

  def revealed_word
    hidden_word unless in_progress?
  end
end
