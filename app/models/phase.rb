class Phase < ApplicationRecord
  has_many :matches, dependent: :destroy
  accepts_nested_attributes_for :matches
  def to_s
    name
  end
end
