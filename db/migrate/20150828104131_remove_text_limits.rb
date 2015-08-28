class RemoveTextLimits < ActiveRecord::Migration
  def up
    change_column :comments, :body, :text, :limit => nil
    change_column :downloads, :file, :text, :limit => nil
    change_column :downloads, :title, :text, :limit => nil
    change_column :downloads, :name, :text, :limit => nil
    change_column :followings, :followed_type, :text, :limit => nil
    change_column :libraries, :name, :text, :limit => nil
    change_column :libraries, :lang, :text, :limit => nil
    change_column :libraries, :host, :text, :limit => nil
    change_column :libraries, :slug, :text, :limit => nil
    change_column :libraries, :icon_path, :text, :limit => nil
    change_column :libraries, :shelf_name, :text, :limit => nil
    change_column :libraries, :logo, :text, :limit => nil
    change_column :libraries, :slogan, :text, :limit => nil
    change_column :libraries, :question, :text, :limit => nil
    change_column :libraries, :ltype, :text, :limit => nil
    change_column :licenses, :name, :text, :limit => nil
    change_column :licenses, :url, :text, :limit => nil
    change_column :licenses, :icon, :text, :limit => nil
    change_column :licenses, :image_url, :text, :limit => nil
    change_column :licenses, :slug, :text, :limit => nil
    change_column :licenses, :license_type, :text, :limit => nil
    change_column :media_bites, :title, :text, :limit => nil
    change_column :media_bites, :caption, :text, :limit => nil
    change_column :media_bites, :link, :text, :limit => nil
    change_column :media_bites, :content_type, :text, :limit => nil
    change_column :media_bites, :file_content, :text, :limit => nil
    change_column :media_bites, :render_as, :text, :limit => nil
    change_column :media_bites, :position, :text, :limit => nil
    change_column :media_bites, :url_content, :text, :limit => nil
    change_column :publishers, :name, :text, :limit => nil
    change_column :publishers, :slug, :text, :limit => nil
    change_column :publishers, :header_url, :text, :limit => nil
    change_column :publishers, :homepage_url, :text, :limit => nil
    change_column :publishers, :archive_slug, :text, :limit => nil
    change_column :references, :title, :text, :limit => nil
    change_column :references, :authors, :text, :limit => nil
    change_column :references, :editor, :text, :limit => nil
    change_column :references, :media, :text, :limit => nil
    change_column :references, :media_type, :text, :limit => nil
    change_column :references, :date, :text, :limit => nil
    change_column :references, :marks, :text, :limit => nil
    change_column :references, :ref_type, :text, :limit => nil
    change_column :references, :archive_slug, :text, :limit => nil
    change_column :references, :tag_names, :text, :limit => nil
    change_column :references, :cover_image, :text, :limit => nil
    change_column :shelves, :name, :text, :limit => nil
    change_column :shelves, :slug, :text, :limit => nil
    change_column :shelves, :color, :text, :limit => nil
    change_column :shelves, :visualization, :text, :limit => nil
    change_column :taggings, :tagged_type, :text, :limit => nil
    change_column :tags, :name, :text, :limit => nil
    change_column :tags, :slug, :text, :limit => nil
    change_column :users, :name, :text, :limit => nil
    change_column :users, :twitter, :text, :limit => nil
    change_column :users, :description, :text, :limit => nil
    change_column :users, :slug, :text, :limit => nil
    change_column :users, :settings, :text, :limit => nil
    change_column :users, :avatar, :text, :limit => nil
    change_column :versions, :title, :text, :limit => nil
    change_column :versions, :user_name, :text, :limit => nil
  end

  def down
  end
end
