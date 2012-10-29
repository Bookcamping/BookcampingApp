class Ability 
  include CanCan::Ability

  def initialize(user, library)
    anonymous_abilities
    if user.present?
      if user.admin?
        admin_abilities(user)
      else
        site_member_abilities(library) if user.site_member?
        user_abilities(user, library)
      end
    else
      no_user_abilities
    end
  end

  def anonymous_abilities
    can :read, Library
    can :read, Notification
    can :read, Reference
    can :read, Review
    can :read, Shelf
    can :read, ShelfItem
    can :read, Tag
    can [:read, :create], User
  end

  def site_member_abilities(library)
    can :create, Library
    can(:manage, License)
  end

  def user_abilities(user, library)
    can(:manage, Library) {|lib| lib.member?(user) }

    can :manage, Membership do |membership|
      membership.library.member?(user)
    end

    can :manage, Reference
    can :manage, Link
    can :manage, Download
    can :create, Review
    can [:update, :destroy], Review, user_id: user.id

    if library && library.protected?
      can :manage, Shelf if library.member?(user)
    else
      can [:create, :update], Shelf
      can :destroy, Shelf, user_id: user.id
    end

    can([:update, :destroy], ShelfItem) do |item| 
      if item.shelf.blank?
        false
      elsif item.shelf.library.member?(user)
        true
      elsif item.user == user
        true
      else
        false
      end
    end
    if library.present? && library.member?(user) 
      can(:manage, ShelfItem)
    end
    can(:create, ShelfItem) unless library.blank? || library.guides?

    can :manage, Subscription, user_id: user.id
    can :update, User, id: user.id

  end

  def no_user_abilities
    can :create, User
  end

  def admin_abilities(user)
    can :create, Library
    can :manage, Version
  end

  def authorize!(action, subject, *args)
    puts "AUTHORIZE! #{action} : #{subject}"
    auth = super(action, subject, *args)
    puts "#{auth} AUTH: #{action} #{subject} #{args}"
    auth
  end
end
