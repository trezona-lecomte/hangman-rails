class ConstrainHiddenWordToNotNull < ActiveRecord::Migration
  def change
    change_column_null :games, :hidden_word, false
  end
end
