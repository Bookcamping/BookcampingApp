module HasMembers
  extend ActiveSupport::Concern

  included do
    has_many :memberships, dependent: :delete_all
    has_many :members, through: :memberships, source: :user

    after_create do
      add_member(self.user)
    end
  end

  def add_member(user)
    Membership.create(library: self, user: user)
  end

  def member?(user)
    Membership.where(library_id: self.id, 
                     user_id: user.id).first.present?
  end
end
