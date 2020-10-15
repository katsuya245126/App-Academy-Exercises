class Album < ApplicationRecord
  validates :title, :year, presence: true
  validates_uniqueness_of :title, scope: :band_id

  belongs_to :band
  has_many :tracks, dependent: :destroy
end
