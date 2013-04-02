class FeaturedContent < ActiveRecord::Migration
  def up
    add_column :libraries, :featured, :boolean, default: false
    Library.where(id: [1,6,12,13]).update_all(featured: true)

    add_column :shelves, :featured, :boolean, default: false
    Shelf.where(id: [4947, 4927]).update_all(featured: true)

    add_column :references, :featured, :boolean, default: false
    Reference.where(id: 2042).update_all(featured: true)
  end

  def down
    [:libraries, :shelves, :references].each do |table|
      remove_column table, :featured
    end
  end
end
