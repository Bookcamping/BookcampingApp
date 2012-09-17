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
      can(:update, Library) {|library| library.member?(user) }
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
      can :manage, ShelfItem
      if user.admin?
        can :manage, Library
        #can :manage, :all
      end
    end
  end

  def can?(action, resource)
    puts "CAN? #{action} #{resource}"
    super(action, resource)
  end
end
