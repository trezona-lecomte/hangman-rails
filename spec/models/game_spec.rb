require "rails_helper"

RSpec.describe Game, type: :model do
  let(:game)     { Game.create(username: name, hidden_word: "test", lives: 6) }
  let(:name)     { Faker::Name.name }
  let(:alphabet) { ("a".."z").to_a }

  describe "#unguessed_letters_of_alphabet" do
    before  { guesses.each { |l| game.guesses.create(letter: l) } }
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

  describe "#obfuscated_letters" do
    before  { guesses.each { |l| game.guesses.create(letter: l) } }
    subject { game.obfuscated_letters("*") }

    context "when no guesses have been made" do
      let(:guesses) { [] }

      it { is_expected.to eq(%w{* * * *}) }
    end

    context "when correct guesses have been made" do
      let(:guesses) { %w{t e} }

      it { is_expected.to eq(%w{t e * t})}
    end

    context "when only incorrect guesses have been made" do
      let(:guesses) { %w{x y z} }

      it { is_expected.to eq(%w{* * * *}) }
    end

    context "when correct and incorrect guesses have been made" do
      let(:guesses) { %w{t j a z} }

      it { is_expected.to eq(%w{t * * t}) }
    end
  end

  describe "#revealed_word" do
    before  { game.update!(status: status) }
    subject { game.revealed_word }

    context "when the game is won" do
      let(:status) { "won" }

      it { is_expected.to eq("test") }
    end

    context "when the game is lost" do
      let(:status) { "lost" }

      it { is_expected.to eq("test") }
    end

    context "when the game is still in progress" do
      let(:status) { "in_progress" }

      it { is_expected.to be_nil }
    end
  end

end
