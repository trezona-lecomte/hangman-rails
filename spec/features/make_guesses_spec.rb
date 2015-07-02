require "rails_helper"

feature "Make guesses" do
  let(:username) { Faker::Name.name }

  before { start_game }

  scenario "making a guess removes their button when the game is in progress" do
    start_game

    click_button "a"

    expect(page).to_not have_button("a")
  end

  def start_game
    visit games_path
    click_button "New game"

    click_button "Start game"
  end
end
