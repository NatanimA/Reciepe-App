class User < ApplicationRecord
  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 15 }
end
