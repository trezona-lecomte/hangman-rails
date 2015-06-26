class MakeGuess
  def call(game:, guess:)
    unless game.hidden_word.include?(guess.letter)
      game.update(lives: game.lives - 1)
    end
  end
end