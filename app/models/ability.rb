class Ability 
  include CanCan::Ability
  def initialize(user)

    can :manage, Reference
    can :manage, Library
    can :manage, Shelf
    if user.present?
    end
  end
end
