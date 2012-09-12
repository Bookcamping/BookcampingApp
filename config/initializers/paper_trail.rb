
class Version < ActiveRecord::Base
  attr_accessible :title, :user_name, :library_id, :extra

  belongs_to :user, foreign_key: :whodunnit, class_name: 'User'
end

