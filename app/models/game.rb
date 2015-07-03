class Game < ActiveRecord::Base
  ALPHABET = ("a".."z").to_a

  has_many :guesses, dependent: :destroy

  validates :hidden_word, :username, :lives, presence: true
  validates :lives, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  enum status: [:in_progress, :won, :lost]

  def unguessed_letters_of_alphabet
    ALPHABET.reject { |l| guesses.any? { |g| g.letter == l } }
  end

  def revealed_letters
    hidden_word.chars.map do |letter|
      correctly_guessed_letters.include?(letter) ? letter : nil
    end
  end

  def lives_remaining
    lives + correctly_guessed_letters.count - guesses.count
  end

  def update_status!
    won! if word_guessed?

    lost! if lives_remaining <= 0
  end

  private

  def correctly_guessed_letters
    hidden_word.chars & guesses.map(&:letter)
  end

  def word_guessed?
    (hidden_word.chars - correctly_guessed_letters).empty?
  end
end
