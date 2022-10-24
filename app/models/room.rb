class Room < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: [:slugged, :finders]

  validates :name, uniqueness: true, presence: true
end
