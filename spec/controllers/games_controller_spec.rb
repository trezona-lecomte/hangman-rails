require "rails_helper"

RSpec.describe GamesController, type: :controller do
  let(:name)   { Faker::Name.name }
  let(:word)   { Faker::Hacker.noun }
  let(:lives)  { 6 }
  let(:games)  { [Game.create(username: name, hidden_word: word, lives: lives),
                  Game.create(username: name, hidden_word: word, lives: lives)] }

  describe "GET #index" do
    before { get :index }

    it "responds with 200 OK" do
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end

    it "loads all of the games" do
      expect(assigns(:games)).to match_array(games)
    end
  end

  describe "GET #show" do
    before do
      get :show, { id: games.first.to_param }
      games.first.guesses.create(letter: "a")
    end

    it "responds with 200 OK" do
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end

    it "loads the requested game" do
      expect(assigns(:game)).to eq(games.first)
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
    before { post :create, game: { username: name, hidden_word: word, lives: lives } }

    it "responds with 302 Redirect" do
      expect(response).to have_http_status(302)
    end

    it "creates a new game" do
      expect{ post :create, game: { username: name, hidden_word: word, lives: lives } }.to change(Game, :count).by(1)
    end
  end
end
