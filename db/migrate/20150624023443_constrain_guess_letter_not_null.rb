class ConstrainGuessLetterNotNull < ActiveRecord::Migration
  def change
    change_column_null :guesses, :letter, false
  end
end
