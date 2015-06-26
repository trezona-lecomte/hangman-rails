class Game < ActiveRecord::Base
  has_many :guesses, dependent: :destroy

  enum status: [:in_progress, :won, :lost]

  ALPHABET = %w{ a b c d e f g h i j k l m n o p q r s t u v w x y z }

  validates :hidden_word, :username, :lives, presence: true

  # TODO: its starting to look like a 'word' PORO would be appropriate
  def unguessed_letters
    ALPHABET.reject { |l| guesses.any? { |g| g.letter == l } }
  end

  def obfuscated_letters(mask_character)
    hidden_word.chars.map do |letter|
      guesses.any? { |g| g.letter == letter } ? letter : mask_character
    end
  end
end
