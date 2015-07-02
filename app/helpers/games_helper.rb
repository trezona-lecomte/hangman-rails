module GamesHelper
  def display_status(game)
    if @game.won?
      render partial: "won"
    elsif @game.lost?
      render partial: "lost"
    else
      render partial: "in_progress"
    end
  end
end
