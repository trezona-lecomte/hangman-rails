class AddHiddenWordToGame < ActiveRecord::Migration
  def change
    add_column :games, :hidden_word, :string
  end
end
