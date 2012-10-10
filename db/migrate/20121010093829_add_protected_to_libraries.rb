class AddProtectedToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :protected, :boolean, default: false

    Library.find_each do |library|
      library.update_attribute(:protected, true) if library.id != 6
    end
  end
end
