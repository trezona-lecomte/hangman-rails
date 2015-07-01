class GuessesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])

    MakeGuess.new(@game).call(guess_params[:letter])

    redirect_to @game
  end

  private
    def guess_params
      params.require(:guess).permit(:letter)
    end
end
