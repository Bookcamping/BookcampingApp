class DropCampsTable < ActiveRecord::Migration
  def up
    drop_table :camps
  end

  def down
  end
end
