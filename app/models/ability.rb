class Ability
  include CanCan::Ability

  def initialize(user)
    can %i[create read show public shoping], Recipe
    can %i[create read show], Food
    can :delete, Recipe, user_id: user.id
    can :delete, Food, user_id: user.id
  end
end
