class Match < ApplicationRecord
  has_many :participants, dependent: :destroy
  accepts_nested_attributes_for :participants

  validates_presence_of :from, :until, :place
  def to_s
    participants.join(" vs ")
  end
end
