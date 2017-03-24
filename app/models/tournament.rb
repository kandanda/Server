class Tournament < ApplicationRecord
  has_many :phases
  validates_presence_of :name, :secret_token

  def set_token!
    raise "Can't change secret token" unless self.secret_token.blank?

    self.secret_token = SecureRandom.hex(16)
    self.save!
  end

  def to_s
    name
  end
end
