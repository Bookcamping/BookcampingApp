class Ability
  include CanCan::Ability

  def initialize(user, library)
    anonymous_abilities
    if user.present?
      user_abilities(user, library)
      admin_abilities(user) if user.admin?
    else
      no_user_abilities
    end
  end

  def anonymous_abilities
    can :read, Library
    can :read, Reference
    can :read, Review
    can :read, Shelf
    can :read, ShelfItem
    can :read, Tag
    can [:read, :create], User
  end

  def admin_abilities(user)
    can :manage, Library
    can(:manage, License)
    can :manage, Version
    can :manage, Shelf
    can :manage, User
    can :manage, ShelfItem
  end

  def user_abilities(user, library)
    can(:manage, Library) {|lib| lib.user == user }

    can :manage, Download
    can :manage, Reference
    can :create, Review
    can [:update, :destroy], Review, user_id: user.id

    if library && library.protected?
      can :manage, Shelf if library.user == user
      can :update, Shelf, user_id: user.id
    else
      can [:create, :update], Shelf
      can :destroy, Shelf, user_id: user.id
    end

    can([:update, :destroy], ShelfItem) do |item|
      if item.shelf.blank?
        false
      elsif item.shelf.library.user == user
        true
      elsif item.user == user
        true
      else
        false
      end
    end
    if library.present? && library.user == user
      can(:manage, ShelfItem)
    end
    can(:create, ShelfItem) unless library.blank? || library.guides?

    can :update, User, id: user.id

    can :delete, Following, user_id: user.id
  end

  def no_user_abilities
    can :create, User
  end


  def authorize!(action, subject, *args)
    puts "AUTHORIZE! #{action} : #{subject}"
    auth = super(action, subject, *args)
    puts "#{auth} AUTH: #{action} #{subject} #{args}"
    auth
  end
end
