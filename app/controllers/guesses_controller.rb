class GuessesController < ApplicationController
  def show
    @game = Game.find(params[:game_id])
    @guess = @game.guesses.find(params[:id])
  end

  def create
    @game = Game.find(params[:game_id])
    @guess = @game.guesses.new(guess_params)

    if @guess.save
      redirect_to game_url(@guess.game_id)
    else
      byebug
      redirect_to game_url(@game)
    end
  end

  private
    def guess_params
      params.require(:guess).permit(:letter)
    end
end
