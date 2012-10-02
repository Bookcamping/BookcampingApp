class Ability 
  include CanCan::Ability

  def initialize(user)
    anonymous_abilities
    if user.present?
      if user.admin? 
        admin_abilities(user) 
      else
        user_abilities(user)
      end
    else
      no_user_abilities
    end
  end

  def anonymous_abilities
    can :read, Activity
    can :read, Library
    can :read, Reference
    can :read, Review
    can :read, Shelf
    can :read, Tag
    can :read, User
  end

  def user_abilities(user)
    can(:manage, Library) {|library| library.member?(user) }

    can :manage, Membership do |membership|
      can? :update, membership.resource
    end

    can :manage, Reference
    can :create, Review
    can [:update, :destroy], Review, user_id: user.id

    can [:create, :update], Shelf
    can :delete, Shelf do |shelf|
      shelf.user_id == user.id
    end
    can :create, ShelfItem
    can([:update, :delete], ShelfItem) do |item| 
      item.shelf.present? && item.shelf.library.member?(user) 
    end
    can :manage, Subscription, user_id: user.id

    can :update, User, id: user.id

  end

  def no_user_abilities
    can :create, User
  end

  def admin_abilities
    can :create, Library
    can :manage, Version
  end
end
