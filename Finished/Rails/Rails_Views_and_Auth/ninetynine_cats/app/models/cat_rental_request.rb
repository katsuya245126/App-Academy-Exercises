class CatRentalRequest < ApplicationRecord
  STATUS = %w[PENDING APPROVED DENIED].freeze

  validates :start_date, :end_date, :status, presence: true
  validates :status, inclusion: STATUS
  validate :does_not_overlap_approved_request
  validate :start_date_before_end_date

  belongs_to :cat

  def approved?
    status == 'APPROVED'
  end

  def denied?
    status == 'DENIED'
  end

  def pending?
    status == 'PENDING'
  end

  def approve!
    raise 'Not pending' unless self.status == 'PENDING'

    transaction do
      self.status = 'APPROVED'
      self.save!

      overlapping_pending_requests.each do |request|
        request.update!(status: 'DENIED')
      end
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save!
  end

  def overlapping_requests
    CatRentalRequest
      .where.not(id: id)
      .where(cat_id: cat_id)
      .where.not('end_date < ? OR start_date > ? ',
                 start_date.to_date, end_date.to_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def does_not_overlap_approved_request
    return if self.denied?

    message = 'There is an overlap with preexisting request'
    errors[:base] << message unless overlapping_approved_requests.empty?
  end

  def start_date_before_end_date
    errors[:base] << 'Start date must be before end date' if start_date > end_date
  end
end
