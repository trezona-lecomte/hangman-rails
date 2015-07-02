require "rails_helper"

RSpec.describe GamePresenter, type: :presenter do
  let(:game)      { Game.create(username: "name", hidden_word: "test", lives: 6) }
  let(:presenter) { GamePresenter.new(game, "view") }

  describe "#masked_letters" do
    let(:masks) { %w{* & %} }

    context "when the hidden_word is fully masked" do
      it "returns an array of masked letters" do
        masks.each do |mask|
            expect(presenter.masked_letters(mask)).to eq("#{mask} #{mask} #{mask} #{mask}")
        end
      end
    end

    context "when the hidden_word is partially masked" do
      before { game.guesses.create(letter: "t") }

      it "return an array of partially masked letters" do
        masks.each do |mask|
            expect(presenter.masked_letters(mask)).to eq("t #{mask} #{mask} t")
        end
      end
    end
  end
end
