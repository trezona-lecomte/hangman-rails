class DefineDefaultForGameState < ActiveRecord::Migration
  def change
    change_column_default :games, :state, 'in_progress'
  end
end
