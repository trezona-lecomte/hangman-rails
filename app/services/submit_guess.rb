class SubmitGuess
  def initialize(game)
    @game = game
  end

  def call(letter)
    @game.with_lock do
      if @game.in_progress?
        @game.guesses.create!(letter: letter)

        @game.update_status!
      end
    end
  end
end
