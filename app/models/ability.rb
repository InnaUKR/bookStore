class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user.admin?
      admin_abilities
    else
      user.guest ? guest_abilities : user_abilities
    end
  end

  def admin_abilities
    can :access, :rails_admin
    can :read, :dashboard
    can :manage, :all
  end

  def guest_abilities
    can :read, Book
    can :read, Category
    can :read, Order, user: user
    can :manage, LineItem
    can :cart, Order
  end

  def user_abilities
    guest_abilities
    can :create, Review
    can :update, Order, user: user
    can :update, User, id: user.id
  end
end
