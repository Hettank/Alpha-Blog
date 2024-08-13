class Article < ApplicationRecord
  # this will make sure that title is present in order for any article we saved
  validates :title, presence: true, length: { minimum: 4 }
  validates :description, presence: true
end