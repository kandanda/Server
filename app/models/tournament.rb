class Tournament < ApplicationRecord
  has_many :phases
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
