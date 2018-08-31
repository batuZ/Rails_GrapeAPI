class User < ApplicationRecord
	has_many :sounds
	has_secure_password
	validates :name, presence: true
end
