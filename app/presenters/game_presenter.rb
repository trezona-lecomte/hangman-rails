class GamePresenter < BasePresenter
  def masked_letters(mask_character)
    @model.revealed_letters.map { |letter| letter ||= mask_character }
  end
end
