class Track < ApplicationRecord
  validates :title, :ord, presence: true

  belongs_to :album
  has_one :band, through: :album
  has_many :notes
end
