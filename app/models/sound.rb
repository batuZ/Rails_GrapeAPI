class Sound < ApplicationRecord
	has_one :position
	belongs_to :user
	has_one_attached :s_file
	validates :s_name, presence: true
end
