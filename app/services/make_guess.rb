class MakeGuess
  def initialize(game)
    @game = game
  end

  def call(letter)
    if @game.status == "in_progress"
      guess = @game.guesses.new(letter: letter)

      if @game.hidden_word.include?(guess.letter)
        if_guessed_already = @game.guesses.map(&:letter).method(:include?)

        letters_still_hidden = @game.hidden_word.chars.reject &if_guessed_already

        @game.update(status: "won") if letters_still_hidden.empty?
      else
        @game.decrement!(:lives) if @game.lives > 0

        @game.update(status: "lost") if @game.lives == 0
      end

      guess.save
    end
  end
end