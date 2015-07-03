module GamesHelper
  def display_status(game)
    if @game.won?
      render partial: "games/won"
    elsif @game.lost?
      render partial: "games/lost"
    else
      render partial: "games/in_progress"
    end
  end
end
