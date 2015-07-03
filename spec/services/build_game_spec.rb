require "rails_helper"

RSpec.describe BuildGame, type: :service do
  let(:game)       { Game.new }
  let(:username)   { Faker::Hacker.noun }
  let(:build_game) { BuildGame.new(game) }

  describe "#call" do
    let(:built_game) { build_game.call(username) }
    subject { built_game }

    context "when the username is valid" do
      let(:username) { "magic_man_69" }

      it "returns a game with the specified username" do
        expect(built_game.username).to eq(username)
      end

      it "returns a game with hidden_word" do
        expect(built_game.hidden_word).to_not be_nil
      end

      it "returns a game with lives" do
        expect(built_game.starting_lives).to_not be_nil
      end
    end

    context "when the username is invalid" do
      let(:username) { "" }

      it "returns an invalid game" do
        expect(built_game).to_not be_valid
      end
    end
  end
end