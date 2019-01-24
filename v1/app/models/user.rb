class User < ApplicationRecord
	has_many :sounds
	has_secure_password :fdsa
	validates :name, presence: true
end
