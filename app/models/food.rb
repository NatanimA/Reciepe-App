class Food < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :recipe_foods

  validates :price, presence: true, comparison: { greater_than_or_equal_to: 1 }
  validates :name, presence: true, length: { minimum: 3, maximum: 15 }

  def to_s
    "#{quantity} #{measurement_unit} of #{name}"
  end
end
