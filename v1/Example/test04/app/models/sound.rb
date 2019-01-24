class Sound < ApplicationRecord
	has_one :position
	belongs_to :user
	validates :url, presence: true

	has_one_attached :sfile
end
