class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: :recipe
  belongs_to :food, class_name: :food
end
