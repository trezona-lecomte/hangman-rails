class DefineDefaultForUsername < ActiveRecord::Migration
  def change
    change_column_default :games, :username, "anonymous"
  end
end
