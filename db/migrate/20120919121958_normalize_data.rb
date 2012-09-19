class NormalizeData < ActiveRecord::Migration
  def up
    User.where(created_at: nil).update_all(created_at: Time.now - 1.year)
  end

  def down
  end
end
