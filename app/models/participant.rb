class Participant < ApplicationRecord
  belongs_to :match
  validates_numericality_of :result, allow_nil: true
  validates_presence_of :name, :match
  def to_s
    name
  end
end
