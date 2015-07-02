class BuildGame
  def initialize(game)
    @game = game
  end

  def call(username)
    @game = Game.new(username: username,
                     hidden_word: Faker::Hacker.noun,
                     lives: 6)
    @game
  end
end