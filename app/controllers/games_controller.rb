class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @guesses = @game.guesses
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(username: game_params[:username], hidden_word: Faker::Hacker.noun, lives: 6)

    if @game.save
      redirect_to @game
    else
      redirect_to games_path
    end
  end

  private
    def game_params
      params.require(:game).permit(:username)
    end
end
