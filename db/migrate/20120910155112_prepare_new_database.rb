# encoding: utf-8
class PrepareNewDatabase < ActiveRecord::Migration
  def up
    PaperTrail.enabled = false
    ActiveRecord::Base.record_timestamps = false

    # Memberships
    drop_table :memberships
    create_table :memberships do |t|
      t.references :library
      t.references :user
    end
    add_index :memberships, :library_id
    add_index :memberships, :user_id

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

    add_column :libraries, :visible_on_header, :boolean, default: false
    [6, 2, 1].each do |id|
      Library.find(id).update_attribute(:visible_on_header, true)
    end

    # TAGS
    drop_table :tags
    drop_table :taggings

    create_table :tags do |t|
      t.string :name, limit: 100
      t.string :slug, limit: 100
      t.integer :taggings_count, default: 0
      t.timestamps
    end

    create_table :taggings do |t|
      t.belongs_to :reference
      t.belongs_to :tag
    end
    add_index :taggings, :reference_id
    add_index :taggings, :tag_id

    # REFERENCES
    add_column :references, :tag_names, :string, limit: 300

    move_shelves_references_and_versions_to_shared_list_library
    add_membership_to_libraries

    add_column :versions, :shelf_id, :integer
    add_shelf_id_to_versions



    drop_table :media_bites
    drop_table :posts
    drop_table :publishers
  end

  def add_shelf_id_to_versions
    ShelfItem.all.each do |item|
      item.versions.update_all(shelf_id: item.shelf_id)
    end
    Shelf.all.each do |shelf|
      shelf.versions.update_all(shelf_id: shelf.id)
    end
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
