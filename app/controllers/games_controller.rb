class GamesController < ApplicationController
  helper :games

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = BuildGame.new(@game).call(game_params[:username])

    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end

  private

  def game_params
    params.require(:game).permit(:username)
  end
end
