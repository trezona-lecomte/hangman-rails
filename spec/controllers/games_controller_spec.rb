require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "GET index" do
    before { get :index }

    it "returns 200 OK" do
      expect(response.status).to be 200
    end

    it "assigns @games" do
      game = Game.create

      expect(assigns(:games)).to eq([game])
    end

    it "renders the index template" do
      expect(response).to render_template(:index)
    end
  end
end
