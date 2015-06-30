class MakeGuess
  def initialize(game)
    @game = game
  end

  def call(letter)
    @game.with_lock do
      if @game.status == "in_progress"
        guess = @game.guesses.new(letter: letter)

        guess.save

        update_game_status(guess)
      end
    end

  end

  private
    def update_game_status(guess)
      if @game.hidden_word.include?(guess.letter)
        @game.update(status: "won") if word_guessed?
      else
        @game.decrement!(:lives) unless all_lives_lost?

        @game.update(status: "lost") if all_lives_lost?
      end
    end

    def word_guessed?
      if_guessed_already = @game.guesses.map(&:letter).method(:include?)

      letters_still_hidden = @game.hidden_word.chars.reject &if_guessed_already

      letters_still_hidden.empty?
    end

    def all_lives_lost?
      @game.lives < 1
    end

end