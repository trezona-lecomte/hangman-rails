require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:alphabet) { %w{ a b c d e f g h i j k l m n o p q r s t u v w x y z } }
  let(:game)     { Game.new(hidden_word: "test") }

  describe "#unguessed_letters" do
    context "when no guesses have been made" do
      it "returns the full alphabet" do
        expect(game.unguessed_letters).to eq(alphabet)
      end
    end

    context "when a guess has been made" do
      %w{a j z}.each do |letter|
        let(:guessed_letter) { letter }
        before { game.guesses.new(letter: guessed_letter) }

        it "doesn't return '#{letter}' when it has been guessed" do
          expect(game.unguessed_letters).to eq(alphabet.reject { |l| l == guessed_letter })
        end
      end
    end
  end

  describe "#obfuscated_letters" do
    context "when no guesses have been made" do
      it "returns only mask characters" do
        expect(game.obfuscated_letters("*")).to eq(["*", "*", "*", "*"])
      end
    end

    context "when a correct guess has been made" do
      before do
        game.guesses.new(letter: "t")
        game.guesses.new(letter: "e")
      end

      it "reveals the letters that were guessed" do
        expect(game.obfuscated_letters("_")).to eq(["t", "e", "_", "t"])
      end
    end
  end
end
