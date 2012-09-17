class Membership < ActiveRecord::Base
  attr_accessor :user_name
  belongs_to :library, counter_cache: true
  belongs_to :user

  validates_presence_of :library_id, :user_id
  validates_uniqueness_of :user_id, :library_id

  before_validation :set_user_by_name

  has_paper_trail meta: {
    title: Proc.new {|m| "#{m.user.name} a '#{m.library.name}'"}
  }

  protected
  def set_user_by_name
    if self.user_name.present?
      self.user = User.find_by_name(self.user_name)
    end
  end
end
