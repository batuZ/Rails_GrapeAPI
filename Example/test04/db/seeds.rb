#user1 = User.create(name: 'administrator')
user2 = User.create(name: 'batu')

sm = 1.0e-10
10.times do 
	#116.22 ~ 116.52
	rx = rand(0.22/sm..0.52/sm)*sm
	randx = 116 + rx
	#39.85 ~ 40.02
	r = rand(39..40)
	rk = r == 39 ? 1 - rand(0.15/sm)*sm : rand(0.02/sm)*sm
	randy = r + rk

	#user1.sounds.create(url: 'https').create_position(x:randx, y:randy, z:0)
	user2.sounds.create(url: 'https').create_position(x:randx, y:randy, z:0)
end