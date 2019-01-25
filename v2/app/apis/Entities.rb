class SoundEnt < Grape::Entity
	expose :uuid, :url
end

class UserEnt < Grape::Entity
	expose :userName, :userBio
	expose :sounds,  using: SoundEnt 
end