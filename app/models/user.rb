class User < ApplicationRecord
  before_save { self.email = email.downcase }

  # this is where association is set with articles and users
  has_many :articles, dependent: :destroy # if user is deleted any associated dependents 'article' will be destroyed as well

  validates :username, presence: true, length: { minimum: 3, maximum: 25 }, uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  # authenticate is a method to verify the user, if user is authenticated then it will return the whole user otherwise 'false'
end
