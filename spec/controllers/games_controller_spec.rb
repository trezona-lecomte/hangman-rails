require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game1) { Game.create!(hidden_word: "magic1") }
  let(:game2) { Game.create!(hidden_word: "magic2") }
  let(:guess1) { game1.guesses.create!(letter: "a") }
  let(:guess2) { game1.guesses.create!(letter: "b") }

  describe "GET #index" do
    before { get :index }

    it "responds with 200 OK" do
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "loads all of the games" do
      expect(assigns(:games)).to match_array([game1, game2])
    end
  end

  describe "GET #show" do
    before { get :show, { id: game1.to_param } }

    it "responds with 200 OK" do
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end

    it "loads the requested game" do
      expect(assigns(:game)).to eq(game1)
    end

    it "loads all of the guesses for the game" do
      expect(assigns(:guesses)).to match_array(game1.guesses)
    end
  end

  describe "GET #new" do
    before { get :new }

    it "responds with 200 OK" do
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end

    it "loads a new game" do
      expect(assigns(:game)).to be_a_new(Game)
    end
  end

  describe "POST #create" do
    before { post :create, game: { username: Faker::Name.name } }

    it "responds with 302 Redirect" do
      expect(response).to have_http_status(302)
    end

    it "creates a new game" do
      expect{ post :create, game: { username: Faker::Name.name } }.to change(Game, :count).by(1)
    end
  end
end
