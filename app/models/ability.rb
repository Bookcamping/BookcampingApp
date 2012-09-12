class Ability 
  include CanCan::Ability

  def initialize(user)
    can :read, Reference
    can :read, User
    can :read, Library
    can :read, Shelf

    if user.present?
      can(:update, Library) {|library| library.member?(user) }
      can :update, User, id: user.id
      can :create, Shelf
      if user.admin?
        can :manage, User
        can :manage, Reference
        can :manage, Library
        can :manage, Shelf
      end
    end
  end

end
