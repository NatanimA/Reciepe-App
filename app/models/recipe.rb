class Recipe < ApplicationRecord
  has_many :recipe_foods,dependent: :destroy
  belongs_to :user

  validates :name, presence: true, length: { minimum: 3, maximum: 150 }
  validates :description, presence: true, length: { minimum: 3, maximum: 200 }
end
