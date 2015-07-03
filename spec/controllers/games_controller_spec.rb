require "rails_helper"

RSpec.describe GamesController, type: :controller do
  let(:name)  { Faker::Name.name }
  let(:games) { [Game.create(username: name, hidden_word: "test", starting_lives: 6),
                 Game.create(username: name, hidden_word: "test", starting_lives: 6)] }

  describe "GET #index" do
    before  { get :index }
    subject { response }

    it { is_expected.to have_http_status(200) }

    it { is_expected.to render_template("index") }

    it "loads all of the games" do
      expect(assigns(:games)).to match_array(games)
    end
  end

  describe "GET #show" do
    before do
      get :show, { id: games.first.to_param }
      games.first.guesses.create(letter: "a")
    end
    subject { response }

    it { is_expected.to have_http_status(200) }

    it { is_expected.to render_template("show") }

    it "loads the requested game" do
      expect(assigns(:game)).to eq(games.first)
    end
  end

  describe "GET #new" do
    before  { get :new }
    subject { response }

    it { is_expected.to have_http_status(200) }

    it { is_expected.to render_template("new") }

    it "loads a new game" do
      expect(assigns(:game)).to be_a_new(Game)
    end
  end

  describe "POST #create" do
    before  { post :create, game: { username: name } }
    subject { response }

    context "when the game is created successfully" do
      it { is_expected.to have_http_status(302) }

      it "creates a new game" do
        expect{ post :create, game: { username: name} }.to change(Game, :count).by(1)
      end
    end

    context "when the game isn't created" do
      let(:name) { "" }

      it { is_expected.to render_template("new") }
    end
  end
end
