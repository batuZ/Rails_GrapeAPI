class Sound < ApplicationRecord
	has_one :position
	belongs_to :user
	has_one_attached :s_file
	validates :uuid, presence: true
end
