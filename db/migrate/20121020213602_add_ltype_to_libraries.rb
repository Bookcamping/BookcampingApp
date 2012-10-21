class AddLtypeToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :ltype, :string, limit: 16, default: 'camping'
  end
end
