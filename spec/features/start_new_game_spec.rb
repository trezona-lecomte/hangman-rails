require "spec_helper"

feature "User starts new game" do
  let(:username) { Faker::Name.name }

  scenario "with a valid username" do
    visit games_path
    click_button "New game"

    fill_in "Username", with: username
    click_button "Start game"

    expect(page).to have_content(username)
    expect(page).to have_content("In Progress")
  end

  scenario "with the default username" do
    visit games_path
    click_button "New game"

    click_button "Start game"

    expect(page).to have_content("anonymous")
    expect(page).to have_content("In Progress")
  end

  scenario "without a username" do
    visit games_path
    click_button "New game"

    fill_in "Username", with: ""
    click_button "Start game"

    expect(page).to have_content("In Progress")
  end
end
