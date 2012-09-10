class Ability 
  include CanCan::Ability
  def initialize(user)

    can :manage, Library
    if user.present?
    end
  end
end
