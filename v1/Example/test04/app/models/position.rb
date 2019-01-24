class Position < ApplicationRecord
	belongs_to :sound
	validates :x, :y, :z, presence: true
end
