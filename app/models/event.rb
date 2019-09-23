# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user
  has_many :event_attendees, foreign_key: 'attended_event_id', dependent: :destroy
  has_many :attendees, through: :event_attendees, source: 'attendee'

  default_scope -> { order(created_at: :desc) }

  # scopes
  scope :upcoming, -> { where('event_date >= :now', now: Time.now) }
  scope :past, -> { where('event_date < :now', now: Time.now) }

  validates :user_id, presence: true
  validates :event_date, presence: true
  validates :description, presence: true, length: { maximum: 200 }

  private

  def date_cannot_be_past
    
      errors.add(:date, 'can not be in the past.') if event_date.present? && event_date < Date.today
    
  end
end
