class Food < ApplicationRecord
  belongs_to :user, class_name: "user"
  has_many   :recipe_food

  validates :name, presence: true, length: {minimum:3, maximum:15}

end
