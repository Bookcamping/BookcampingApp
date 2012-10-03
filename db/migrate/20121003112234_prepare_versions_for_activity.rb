class PrepareVersionsForActivity < ActiveRecord::Migration
  def up
    add_column :users, :email_pending, :boolean, default: false
    add_column :versions, :activity, :boolean, default: true
    add_column :versions, :user_id, :integer
    add_index :versions, :user_id
    add_index :versions, :shelf_id

    create_table :notifications do |t|
      t.belongs_to :user
      t.belongs_to :version
      t.boolean :mail_pending, default: false
    end
    add_index :notifications, :user_id
    add_index :notifications, :version_id

    # Update version data
    m15 = Time.new('2011', '3', '15')
    PaperTrail.enabled = false
    ActiveRecord::Base.record_timestamps = false
    Version.find_each do |version|
      user_id = version.whodunnit.to_i if version.whodunnit?
      version.user_id = user_id if user_id != 0

      if version.item_type == 'ShelfItem'
        item = version.item
        version.shelf_id = item.shelf_id if item
      end
      version.created_at ||= m15
      version.activity = version.event != 'update'
      version.save
    end
  end

  def down
    remove_column :users, :email_pending
    remove_column :versions, :user_id
    remove_column :versions, :activity
    drop_table :notifications
  end
end
