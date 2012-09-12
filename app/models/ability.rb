class Ability 
  include CanCan::Ability
  def initialize(user)

    can :read, Reference
    can :read, User

    if user.present?
      can :update, Library
      if user.admin?
        can :manage, User
        can :manage, Reference
        can :manage, Library
        can :manage, Shelf
      end
    end
  end
end
