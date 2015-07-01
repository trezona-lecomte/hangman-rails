require "rails_helper"

RSpec.describe MakeGuess, type: :service do
  let(:game)       { Game.create(username: Faker::Name.name, hidden_word: word, lives: 6) }
  let(:word)       { "test" }
  let(:make_guess) { MakeGuess.new(game) }

  describe "#call" do
    context "when the guess is incorrect" do
      let(:letter) { "a" }
      subject { make_guess.call(letter) }

      context "when the game has at least 1 life left" do

        context "when the game is updated to have at least 1 life" do
          before { game.update(lives: 2) }

          it "decrements lives" do
            expect{ make_guess.call(letter) }.to change(game, :lives).by(-1)
          end

          it "doesn't change the status" do
            expect{ make_guess.call(letter) }.to_not change(game, :status)
          end
        end

        context "when the game is updated from 1 to 0 lives" do
          before { game.update(lives: 1) }

          it "decrements lives" do
            expect{ make_guess.call(letter) }.to change(game, :lives).by(-1)
          end

          it "changes the status from in_progress to lost" do
            expect{ make_guess.call(letter) }.to change(game, :status).from("in_progress").to("lost")
          end
        end
      end

      context "when the game has no lives left" do
        before { game.update(lives: 0) }

        it "doesn't decrement lives" do
          expect{ make_guess.call(letter) }.to_not change(game, :lives)
        end
      end
    end

    context "when the guess is correct" do
      let(:letter) { "e" }

      it "doesn't decrement lives" do
        expect{ make_guess.call(letter) }.to_not change(game, :lives)
      end

      context "when all letters have been guessed" do
        before { %w{e s}.each { |l| game.guesses.create(letter: l) } }

        it "changes the status from in_progress to won" do
          expect{ make_guess.call("t") }.to change(game, :status).from("in_progress").to("won")
        end
      end

      context "when not all of the letters have been guessed" do
        it "doesn't update the game status" do
          expect{ make_guess.call(letter) }.to_not change(game, :status)
        end
      end
    end

    context "when the game isn't 'in_progress'" do
      let(:letter) { "e" }

      context "when the game is won" do
        before { game.update(status: "won") }

        it "doesn't add further guesses" do
          expect{ make_guess.call(letter) }.to_not change{ game.guesses.count }
        end
      end

      context "when the game is lost" do
        before { game.update(status: "lost") }

        it "doesn't add further guesses" do
          expect{ make_guess.call(letter) }.to_not change{ game.guesses.count }
        end
      end
    end
  end
end
