class ConstrainGameStatusNotNull < ActiveRecord::Migration
  def change
    change_column_null :games, :status, false
  end
end
