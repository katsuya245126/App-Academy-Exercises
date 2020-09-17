# frozen_string_literal: true

class Artwork < ApplicationRecord
  validates :title, :image_url, presence: true
  validates :title, uniqueness: { scope: :artist_id, message: 'Cannot have more than one artwork with the same title' }

  belongs_to :artist,
             class_name: :User

  has_many :shares,
           class_name: :ArtworkShare

  has_many :shared_viewers,
           through: :shares,
           source: :viewer

  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable
end
