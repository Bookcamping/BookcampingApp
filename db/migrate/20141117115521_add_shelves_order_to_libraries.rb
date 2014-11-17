class AddShelvesOrderToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :shelves_order, :text

    Library.find_each do |library|
      order = library.fixed_shelf_order ? 'last_created_last' : 'last_modified_first'
      library.update_column(:shelves_order, order)
    end
    remove_column :libraries, :fixed_shelf_order
  end
end
