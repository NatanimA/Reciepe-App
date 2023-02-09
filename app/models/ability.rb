class Ability
  include CanCan::Ability

  def initialize(user)
    can %i[create read show public shoping], Recipe
    can %i[create read show], Food
    can %i[delete destroy], Recipe, user_id: user.id
    can %i[delete destroy], Food, user_id: user.id
  end
end
