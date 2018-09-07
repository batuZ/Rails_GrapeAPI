User.create(name: 'sys', password: 'admin', password_confirmation: 'admin')
User.create(name: 'admin', password: 'admin', password_confirmation: 'admin')
sys = User.create(name: 'batu', password: '123456', password_confirmation: '123456')

# 设置随机sound WGS84
	# sm = 1.0e-10
	# 10.times do 
	# 	#116.22 ~ 116.52
	# 	rx = rand(0.22/sm..0.52/sm)*sm
	# 	randx = 116 + rx
	# 	#39.85 ~ 40.02
	# 	r = rand(39..40)
	# 	rk = r == 39 ? 1 - rand(0.15/sm)*sm : rand(0.02/sm)*sm
	# 	randy = r + rk

	# 	#user1.sounds.create(url: 'https').create_position(x:randx, y:randy, z:0)
	# 	user2.sounds.create(url: 'https').create_position(x:randx, y:randy, z:0)
	# end

# 设置随机sound Mercator
	# 范围
	# w:
	# longitude    CLLocationDegrees    12925344.752049109
	# e:
	# longitude    CLLocationDegrees    12992040.394812275
	# n:
	# latitude    CLLocationDegrees    4891929.6882040696
	# s:
	# latitude    CLLocationDegrees    4823229.7204252267

uu = UUID.new
3000.times do |i|
	we_x = rand + rand(12925344..12992040)
	sn_y = rand + rand(4823229..4891929)
	z = rand + rand(0..240)
	sys.sounds.create(uuid: uu.generate).create_position(x:we_x, y:sn_y, z:z)
end

# myTestLocation:
# lat: 4859704.907215
# lon: 12953735.635967