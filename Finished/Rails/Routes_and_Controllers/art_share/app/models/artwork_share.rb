# frozen_string_literal: true

class ArtworkShare < ApplicationRecord
  validates :artwork_id,
            uniqueness: { scope: :viewer_id, message: 'cannot share the same artwork to the same person more than once' }

  belongs_to :viewer, class_name: :User, foreign_key: :viewer_id
  belongs_to :artwork
end
