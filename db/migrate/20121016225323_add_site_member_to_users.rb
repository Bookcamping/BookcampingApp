class AddSiteMemberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :site_member, :boolean, default: false

    ActiveRecord::Base.record_timestamps = false
    PaperTrail.without_versioning do
      Library.find(1).members.each do |user|
        user.update_attribute(:site_member, true)
      end
    end
  end
end
