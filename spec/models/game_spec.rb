require "rails_helper"

RSpec.describe Game, type: :model do
  let(:game)     { Game.create(username: name, hidden_word: "test", lives: 6) }
  let(:name)     { Faker::Name.name }
  let(:alphabet) { ("a".."z").to_a }

  describe "#unguessed_letters_of_alphabet" do
    before  { guesses.each { |letter| game.guesses.create(letter: letter) } }
    subject { game.unguessed_letters_of_alphabet }

    context "when no guesses have been made" do
      let(:guesses) { [] }

      it { is_expected.to eq(alphabet) }
    end

    context "when a guess has been made" do
      let(:guesses) { ["j"] }

      it { is_expected.to_not include("j") }
    end
  end

  describe "#revealed_letters" do
    before  { guesses.each { |letter| game.guesses.create(letter: letter) } }
    subject { game.revealed_letters }

    context "when no guesses have been made" do
      let(:guesses) { [] }

      it { is_expected.to eq([nil, nil, nil, nil]) }
    end

    context "when correct guesses have been made" do
      let(:guesses) { %w{e t} }

      it { is_expected.to eq(["t", "e", nil, "t"])}
    end

    context "when only incorrect guesses have been made" do
      let(:guesses) { %w{x y z} }

      it { is_expected.to eq([nil, nil, nil, nil]) }
    end

    context "when correct and incorrect guesses have been made" do
      let(:guesses) { %w{j t a z} }

      it { is_expected.to eq(["t", nil, nil, "t"]) }
    end
  end

  describe "#update_status!" do
    before  { prior_guesses.each { |l| game.guesses.create(letter: l) } }
    subject { lambda { game.update_status! } }

    context "when the word has been guessed" do
      let(:prior_guesses) { %w{t e s}}

      it { is_expected.to change{game.status}.from("in_progress").to("won") }
    end

    context "when the word hasn't yet been guessed and there are lives remaining" do
      let(:prior_guesses) { %w{t e} }

      it { is_expected.to_not change{game.status} }
    end

    context "when there are still lives remaining" do
      let(:prior_guesses) { %w{t e z} }

      it { is_expected.to_not change{game.status} }
    end

    context "when there are no lives remaining" do
      let(:prior_guesses) { %w{z y x w v u} }

      it { is_expected.to change{game.status}.from("in_progress").to("lost") }
    end

    context "when the game is won on the last guess" do
      let(:prior_guesses) { %w{z y x t e s} }

      it { is_expected.to change{game.status}.from("in_progress").to("won") }
    end
  end

  describe "#lives_remaining" do
    before  { prior_guesses.each { |l| game.guesses.create(letter: l) } }
    subject { game.lives_remaining }

    context "when there are no guesses" do
      let(:prior_guesses) { [] }

      it { is_expected.to eq(game.lives) }
    end

    context "when 6 incorrect guesses have been made" do
      let(:prior_guesses) { %w{z y x r q v} }

      it { is_expected.to eq(game.lives - 6) }
    end

    context "when 3 incorrect guesses and 2 correct guesses have been made" do
      let(:prior_guesses) { %w{z y x t e} }

      it { is_expected.to eq(game.lives - 3) }
    end

    context "when 5 incorrect guesses and 3 correct guesses have been made" do
      let(:prior_guesses) { %w{z y x r q t e s} }

      it { is_expected.to eq(game.lives - 5) }
    end
  end
end
