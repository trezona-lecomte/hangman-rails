require "rails_helper"

RSpec.describe MakeGuess, type: :service do
  let(:game)       { Game.create(username: Faker::Name.name, hidden_word: word, lives: 6) }
  let(:guess)      { game.guesses.create(letter: letter) }
  let(:make_guess) { MakeGuess.new }

  describe "#call" do
    let(:word)   { "test" }

    context "when the guess is incorrect" do
      let(:letter) { "a" }

      it "updates the lives remaining" do
        expect{ make_guess.call(game: game, guess: guess) }.to change(game, :lives).by(-1)
      end
    end

    context "when the guess is correct" do
      let(:letter) { "e" }

      it "doesn't update the lives remaining" do
        expect{ make_guess.call(game: game, guess: guess) }.to_not change(game, :lives)
      end
    end
  end
end