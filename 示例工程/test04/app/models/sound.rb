class Sound < ApplicationRecord
	has_one :position
	belongs_to :user
	validates :url, presence: true
end
