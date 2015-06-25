class DefineDefaultForGameStatus < ActiveRecord::Migration
  def change
    change_column_default :games, :status, 'In Progress'
  end
end
