class AddLetterToGuesses < ActiveRecord::Migration
  def change
    add_column :guesses, :letter, :string, limit: 1
  end
end
