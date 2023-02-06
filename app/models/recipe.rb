class Recipe < ApplicationRecord
  has_many :recipe_food
  belongs_to :user

  validates :name, presence: true, length: {minimum:3, maximum:15}
  validates :description, presence: true, length: {minimum:3, maximum:200}
end
