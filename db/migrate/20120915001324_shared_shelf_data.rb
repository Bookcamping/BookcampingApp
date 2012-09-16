class SharedShelfData < ActiveRecord::Migration
  def up
    PaperTrail.enabled = false

    library = Library.find 6
    library.shelves.each do |shelf|
      PaperTrail.enabled = false
      shelf.update_attribute(:library_id, 6)
      shelf.shelf_items.update_all(library_id: 6)
      shelf.shelf_items.each do |item|
        ref = item.reference
        if ref.shelves.count == 1
          PaperTrail.enabled = false
          ref.update_attribute(:library_id, 6)
          ref.versions.update_all(library_id: 6)
        end
      end
      ['silvink', 'dani', 'kamen', 'maria-castello-solbes', 'bookcamping', 'jessica-romero', 'gaelx'].each do |user|
        Library.all.each do |lib|
          lib.add_member(User.find_by_slug!(user))
        end
      end
    end
  end

  def down
  end
end
