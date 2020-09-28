class Cat < ApplicationRecord
  COLORS = %w[Black White Orange Brown].freeze

  validates :name, :sex, :birth_date, :color, presence: true
  validates :sex, inclusion: %w[M F]
  validates :color, inclusion: COLORS
  validate :validate_past_date, if: :birth_date_present?

  has_many :rental_requests, class_name: 'CatRentalRequest', dependent: :destroy

  def age
    ((Time.current - Time.parse(birth_date.to_s)) / 1.year).round
  end

  private

  def validate_past_date
    errors.add(:birth_date, 'cannot be in the future') unless self.birth_date < Time.current
  end

  def birth_date_present?
    self.birth_date.present?
  end
end
