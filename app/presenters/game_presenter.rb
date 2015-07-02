class GamePresenter < BasePresenter
  def masked_letters(mask_character)
    letters = @model.revealed_letters.map { |letter| letter ||= mask_character }
    letters.join(" ")
  end
end
