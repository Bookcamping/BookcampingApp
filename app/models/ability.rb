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
      can [:create, :update], Shelf
      can :delete, Shelf do |shelf|
        shelf.user_id == user.id
      end
      can :manage, Membership do |membership|
        can? :update, membership.resource
      end
      can :manage, Reference
      if user.admin?
        #can :manage, :all
      end
    end
  end

  def can?(action, resource)
    puts "CAN? #{action} #{resource}"
    super(action, resource)
  end
end
