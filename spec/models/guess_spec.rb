require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:game) { Game.new(hidden_word: "magic", lives: 6) }

  describe "guess creation" do
    subject(:guess) { game.guesses.build(letter: letter) }

    context "when the guess is in the game's alphabet" do
      let(:letter)    { "a" }

      it { is_expected.to be_valid }
    end

    context "when the guess isn't in the game's alphabet" do
      %w{% A © ß}.each do |l|
        let(:letter) { l }

        it "returns a record invalid error for #{l}" do
            expect(guess).to have(1).error_on(:letter)
        end
      end
    end
  end
end
