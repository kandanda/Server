class Tournament < ApplicationRecord
  has_many :phases
  validates_presence_of :name

  def to_s
    name
  end
end
