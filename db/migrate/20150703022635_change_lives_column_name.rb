class ChangeLivesColumnName < ActiveRecord::Migration
  def change
    rename_column :games, :lives, :starting_lives
  end
end
