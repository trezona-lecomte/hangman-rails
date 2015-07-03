require "rails_helper"

RSpec.describe SubmitGuess, type: :service do
  let(:game)         { Game.create(username: Faker::Name.name, hidden_word: word, starting_lives: 6) }
  let(:word)         { "test" }
  let(:submit_guess) { SubmitGuess.new(game) }

  describe "#call" do
    subject { lambda { submit_guess.call(letter) } }

    context "when the game is in progress" do
      before { allow(game).to receive(:in_progress?).and_return true }

      context "when guessed letter is valid" do
        let(:letter) { "a" }

        it { is_expected.to change{ game.guesses.count } }
      end

      context "when the guessed letter is invalid" do
        let(:letter) { "%" }

        it { is_expected.to raise_error(ActiveRecord::RecordInvalid) }
      end
    end

    context "when the game isn't in progress" do
      before { allow(game).to receive(:in_progress?).and_return false }

      context "when guessed letter is valid" do
        let(:letter) { "e" }

        it { is_expected.to_not change{ game.guesses.count } }
      end

      context "when the guessed letter is invalid" do
        let(:letter) { "*" }

        it { is_expected.to_not change{ game.guesses.count } }
      end
    end
  end
end
