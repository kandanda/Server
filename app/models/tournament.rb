class Tournament < ApplicationRecord
  has_many :phases
  has_many :matches, through: :phases
  has_many :participants, through: :matches
  has_many :tournament_subscriptions
  validates_presence_of :name, :secret_token
  before_validation do
    self.set_token
  end

  def to_s
    name
  end

  protected
  def set_token
    self.secret_token ||= SecureRandom.hex(16)
  end
end
