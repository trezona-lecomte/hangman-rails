class ConstrainGameStateNotNull < ActiveRecord::Migration
  def change
    change_column_null :games, :state, false
  end
end
