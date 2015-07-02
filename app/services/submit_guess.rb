class SubmitGuess
  def initialize(game)
    @game = game
  end

  def call(letter)
    @game.with_lock do
      @game.in_progress? && @game.guesses.create!(letter: letter)
    end
  end
end
