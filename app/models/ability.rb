class Ability 
  include CanCan::Ability

  def initialize(user)
    puts "ABILITY #{user.inspect}"
    can :read, Reference
    can :read, User
    can :read, Library
    can :read, Shelf

    if user.present?
      can :update, Library
      can :update, User, id: user.id
      if user.admin?
        can :manage, User
        can :manage, Reference
        can :manage, Library
        can :manage, Shelf
      end
    end
  end

  def authorize!(action, subject, *args)
    puts "JODER #{action} #{subject} #{args}"
    super(action, subject, *args)
  end
end
