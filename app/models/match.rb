class Match < ApplicationRecord
  has_many :participants, dependent: :destroy
  accepts_nested_attributes_for :participants

  belongs_to :phase
  validates_presence_of :from, :until, :place, :phase
  validate do
    unless self.from < self.until
      self.errors.add(:until, "must be after from")
    end
  end
end
