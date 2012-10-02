class Ability 
  include CanCan::Ability

  def initialize(user)
    can :read, Reference
    can :read, User
    can :read, Library
    can :read, Shelf
    can :read, Tag
    can :read, Activity

    if user.present?
      can(:manage, Library) {|library| library.member?(user) }
      can :update, User, id: user.id
      can [:create, :update], Shelf
      can :delete, Shelf do |shelf|
        shelf.user_id == user.id
      end
      can :manage, Membership do |membership|
        can? :update, membership.resource
      end
      can :manage, Subscription, user_id: user.id
      can :manage, Reference
      can :create, ShelfItem
      can(:delete, ShelfItem) {|item| item.library.present? && item.library.member?(user) }
      if user.admin?
        can :create, Library
        can :manage, Version
        #can :manage, :all
      end
    else
      can :create, User
    end
  end

  def can?(action, subject, *extra_args)
    allowed = super(action, subject, *extra_args)
    Rails.logger.debug "CanCan not allowed: #{action} #{subject}" unless allowed
    allowed
  end
end
