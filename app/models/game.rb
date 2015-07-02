class Game < ActiveRecord::Base
  ALPHABET = ("a".."z").to_a

  has_many :guesses,
            dependent: :destroy,
            after_add: :update_status!

  validates :hidden_word, :username, :lives, presence: true

  enum status: [:in_progress, :won, :lost]

  def unguessed_letters_of_alphabet
    ALPHABET.reject { |l| guesses.any? { |g| g.letter == l } }
  end

  def revealed_letters
    hidden_word.chars.map do |letter|
      correctly_guessed_letters.include?(letter) ? letter : nil
    end
  end

  private

  def update_status!(guess)
    if hidden_word.include?(guess.letter)
      won! if word_guessed?
    else
      decrement!(:lives) if lives > 0

      lost! if lives < 1
    end
  end

  def correctly_guessed_letters
    hidden_word.chars & guesses.map(&:letter)
  end

  def word_guessed?
    (hidden_word.chars - correctly_guessed_letters).empty?
  end
end
