class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Add the new validations for email and password
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }, if: -> { password.nil? }

  # Update the existing associations
  has_many :foods, dependent: :destroy
  has_many :recipes, dependent: :destroy

  # Update the existing name validation
  validates :name, presence: true, length: { minimum: 3, maximum: 40 }
end
