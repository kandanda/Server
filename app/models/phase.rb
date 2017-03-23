class Phase < ApplicationRecord
  belongs_to :tournament
  has_many :matches, dependent: :destroy
  accepts_nested_attributes_for :matches

  validates_presence_of :tournament, :name, :from, :until
  validate do
    unless self.from && self.until && self.from < self.until
      self.errors.add(:until, "must be after from")
    end
  end

  def to_s
    name
  end
end
