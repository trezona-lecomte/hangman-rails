class GuessesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])

    begin
      SubmitGuess.new(@game).call(guess_params[:letter])
      redirect_to @game
    rescue
      redirect_to @game, alert: "Sorry, that guess can't be submitted."
    end
  end

  private

  def guess_params
    params.require(:guess).permit(:letter)
  end
end
