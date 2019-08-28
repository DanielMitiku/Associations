class User < ApplicationRecord
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true
  validates :email, presence: true, length: {maximum: 255 },
  format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_many :events,  dependent: :destroy
  has_many :event_attendees, :foreign_key =>  "attendee_id"
  has_many :attended_events,  :through => :event_attendees
  
end
