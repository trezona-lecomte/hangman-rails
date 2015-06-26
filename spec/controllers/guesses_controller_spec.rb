require 'rails_helper'

RSpec.describe GuessesController, type: :controller do
  let(:game)  { Game.create(hidden_word: "magic1", lives: 6) }
  let(:guess) { game.guesses.create!(letter: "a", game: game) }

  describe "POST #create" do
    it "creates a new guess" do
      expect{ post :create, game_id: game.to_param, guess: { letter: "a" } }.to change(Guess, :count).by(1)
    end
  end
end
