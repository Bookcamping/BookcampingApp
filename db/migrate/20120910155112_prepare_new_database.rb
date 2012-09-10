class PrepareNewDatabase < ActiveRecord::Migration
  def up
    rename_table :camps, :libraries
  end

  def down
    rename_table :libraries, :camps
  end
end
