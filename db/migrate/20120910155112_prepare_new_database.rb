# encoding: utf-8
class PrepareNewDatabase < ActiveRecord::Migration
  def up
    PaperTrail.enabled = false

    # USERS
    add_column :users, :versions_count, :integer, default: 0
    execute "update users set versions_count=(select count(*) from versions where whodunnit=cast(users.id AS TEXT))"
    execute "update versions set item_type='Reference' where item_type='Book'"
    execute "update versions set item_type='Shelf' where item_type='BookList'"

    add_column :users, :admin, :boolean, default: false
    User.where('rol is not null').update_all(admin: true)
    remove_column :users, :rol
    User.find_by_slug!('dani').update_attribute(:admin, true)
    admin = User.find(3)
    admin.update_attributes(name: 'Admin', 
                            email: 'admin@bookcamping.cc',
                            twitter: 'bookcamping',
                            description: 'Administradora de bookcamping',
                            password: 'adminadmin',
                            password_confirmation: 'adminadmin',
                            uid_twitter: nil,
                            uid_facebook: nil,
                            uid_google: nil)

    # SHELVES
    execute "update shelves set camp_id=6 where type='UserShelf'"
    remove_column :shelves, :type

    # LIBRARIES
    rename_table :camps, :libraries
    [:comments, :references, :shelf_items, :shelves, :versions].each do |table|
      rename_column table, :camp_id, :library_id
    end
    add_column :libraries, :open, :boolean, default: true
    add_column :libraries, :last_activity_email_at, :datetime
    Library.update_all(last_activity_email_at: Time.now)
    add_column :libraries, :icon_path, :string, limit: 100
    Library.update_all(icon_path: 'logos/bookcamping.png')
    add_column :libraries, :shelf_name, :string, limit: 100
    Library.update_all(shelf_name: 'estantería')
    add_column :libraries, :description, :text
    move_shelves_references_and_versions_to_shared_list_library
    add_membership_to_libraries

    drop_table :media_bites
    drop_table :posts
    drop_table :publishers
  end

  def add_membership_to_libraries
    ['silvink', 'dani', 'kamen', 'maria-castello-solbes', 'bookcamping', 'jessica-romero', 'gaelx'].each do |user|
      Library.all.each do |lib|
        lib.add_member(User.find_by_slug!(user))
      end
    end
  end

  def move_shelves_references_and_versions_to_shared_list_library
    library = Library.find 6
    library.shelves.each do |shelf|
      shelf.update_attribute(:library_id, 6)
      shelf.shelf_items.update_all(library_id: 6)
      shelf.shelf_items.each do |item|
        ref = item.reference
        if ref.shelves.count == 1
          ref.update_attribute(:library_id, 6)
          ref.versions.update_all(library_id: 6)
        end
      end
    end
  end

  def down
  end
end
