class Person < ApplicationRecord
  validates :name, presence: true

  belongs_to :house
end
