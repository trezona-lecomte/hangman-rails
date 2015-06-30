require "rails_helper"

RSpec.describe Game, type: :model do
  let(:game)     { Game.create(username: name, hidden_word: "test", lives: 6) }
  let(:name)     { Faker::Name.name }
  let(:alphabet) { ("a".."z").to_a }

  describe "#unguessed_letters_of_alphabet" do
    subject { game.unguessed_letters_of_alphabet }

    context "when no guesses have been made" do
      it { is_expected.to eq(alphabet) }
    end

    context "when a guess has been made" do
      before { game.guesses.create(letter: letter) }
      let(:letter) { "j" }

      it { is_expected.to_not include(letter) }
    end
  end

  describe "#obfuscated_letters" do
    subject { game.obfuscated_letters("*") }

    context "when no guesses have been made" do
      it { is_expected.to eq(%w{* * * *}) }
    end

    context "when correct guesses have been made" do
      before { %w{t e}.each { |l| game.guesses.new(letter: l) } }

      it { is_expected.to eq(%w{t e * t})}
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
