class Participant < ApplicationRecord
  belongs_to :match
  def to_s
    name
  end
end
