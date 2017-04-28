class TournamentSubscription < ApplicationRecord
  belongs_to :tournament
  validates_presence_of :tournament, :email, :unsubscribe_token
  validates_uniqueness_of :email, scope: :tournament
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  before_validation do
    self.unsubscribe_token ||= SecureRandom.hex(16)
  end
end
