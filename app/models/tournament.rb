class Tournament < ApplicationRecord
  has_many :phases
  validates_presence_of :name, :secret_token
  before_validation do
    self.set_token
  end

  def set_token!
    raise "Can't change secret token" unless self.secret_token.blank?

    self.set_token
    self.save!
  end

  def to_s
    name
  end

  protected
  def set_token
    self.secret_token ||= SecureRandom.hex(16)
  end
end
