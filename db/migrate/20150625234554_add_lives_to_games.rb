class AddLivesToGames < ActiveRecord::Migration
  def change
    add_column :games, :lives, :integer
  end
end
