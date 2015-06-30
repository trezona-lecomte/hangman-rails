require "rails_helper"

RSpec.describe Game, type: :model do
  let(:alphabet) { %w{ a b c d e f g h i j k l m n o p q r s t u v w x y z } }
  let(:game)     { Game.create(username: name, hidden_word: word, lives: lives) }
  let(:name)     { Faker::Name.name }
  let(:word)     { Faker::Hacker.noun }
  let(:lives)    { word.length + 2 }

  describe "#create" do
    context "when a username & hidden_word are given" do
      it "assigns the username" do
        expect(game.username).to eq(name)
      end

      it "assigns the hidden_word" do
        expect(game.hidden_word).to eq(word)
      end

      it "assigns the lives remaining to be the length of the hidden_word + 2" do
        expect(game.lives).to eq(lives)
      end
    end
  end

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
    let(:word) { "test" }

    context "when no guesses have been made" do
      it "returns only mask characters" do
        expect(game.obfuscated_letters("*")).to eq(["*", "*", "*", "*"])
      end
    end

    context "when a correct guess has been made" do
      before { %w{t e}.each { |l| game.guesses.new(letter: l) } }

      it "reveals the letters that were guessed" do
        expect(game.obfuscated_letters("_")).to eq(["t", "e", "_", "t"])
      end
    end
  end
end
