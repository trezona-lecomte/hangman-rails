require 'rails_helper'

RSpec.describe GuessesController, type: :controller do
  let(:game)   { Game.create(hidden_word: "magic", lives: 6) }

  describe "POST #create" do
    context "when the guess is submitted successfully" do
      it "creates a new guess" do
        expect{ post :create, game_id: game.to_param, guess: { letter: "a" } }.to change{game.guesses.count}.by(1)
      end
    end

    context "when the guess isn't submitted" do
      before { post :create, game_id: game.to_param, guess: { letter: "%" } }

      it "returns an error" do
        expect(flash[:alert]).to be_present
      end
    end
  end
end
