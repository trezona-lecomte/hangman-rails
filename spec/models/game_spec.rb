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

  describe "#adding guesses" do
    before  { prior_guesses.each { |l| game.guesses.create(letter: l) } }
    subject { lambda { game.guesses.create(letter: guessed_letter) } }

    context "when the last guess was correct" do
      context "when the word has been guessed" do
        let(:prior_guesses) { %w{t e}}
        let(:guessed_letter)  { "s" }

        it { is_expected.to_not change{game.lives} }
        it { is_expected.to change{game.status}.from("in_progress").to("won") }
      end

      context "when the word hasn't yet been guessed" do
        let(:prior_guesses) { %w{t} }
        let(:guessed_letter)  { "e" }

        it { is_expected.to_not change{game.lives} }
        it { is_expected.to_not change{game.status} }
      end
    end

    context "when the last guess was incorrect" do
      context "when there are still lives left after this guess" do
        let(:prior_guesses) { %w{t e} }
        let(:guessed_letter)  { "z" }

        it { is_expected.to change{game.lives}.by(-1) }
        it { is_expected.to_not change{game.status} }
      end

      context "when there are no lives left due to this guess" do
        let(:prior_guesses) { %w{z y x w v} }
        let(:guessed_letter)  { "u" }

        it { is_expected.to change{game.lives}.by(-1) }
        it { is_expected.to change{game.status}.from("in_progress").to("lost") }
      end

      context "when there are no lives left prior to this guess" do
        let(:prior_guesses) { %w{z y x w v u} }
        let(:guessed_letter)  { "r" }

        it { is_expected.to_not change{game.lives} }
        it { is_expected.to_not change{game.status} }
      end
    end
  end
end
