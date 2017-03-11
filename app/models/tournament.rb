class Tournament < ApplicationRecord
  has_many :phases

  def to_s
    name
  end
end
