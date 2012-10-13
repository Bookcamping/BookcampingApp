class CleanVersions < ActiveRecord::Migration
  def up
    PaperTrail.without_versioning do
      Version.where(item_type: 'Reference', event: 'update',
                    user_id: nil).destroy_all

      Version.find_each do |version|
        version.update_attribute(:activity, Activity.activity?(version))
      end
    end
  end

  def down
  end
end
