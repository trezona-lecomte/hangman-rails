require "rails_helper"

feature "Start new game" do
  let(:username) { Faker::Name.name }

  scenario "is successful with a valid username" do
    visit games_path
    click_button "New game"

    fill_in "Username", with: username
    click_button "Start game"

    expect(page).to have_content(username)
    expect(page).to have_content("In progress")
  end

  scenario "is successful with the default username" do
    visit games_path
    click_button "New game"

    click_button "Start game"

    expect(page).to have_content("anonymous")
    expect(page).to have_content("In progress")
  end

  scenario "is unsuccessful without a username" do
    visit games_path
    click_button "New game"

    fill_in "Username", with: ""
    click_button "Start game"

    expect(page).to_not have_content("In progress")
  end
end
