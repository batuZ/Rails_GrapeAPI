module StatusManagerHelpers
	# 通过传入的坐标和范围，在数据库中找到相交的记录并返回
	def find_my_sounds_byBox(x, y, range_get)
		# 范围的包围盒求交，就是最大最小值
		minx = x - range_get
		miny = y - range_get
		maxx = x + range_get
		maxy = y + range_get

		res=[]
		Position.all.each do |s|
			if s.x > minx and s.x < maxx and s.y > miny and s.y < maxy
				res << s.sound
			end
		end
		return res
	end
	
	def find_my_sounds_byJuLi(x, y, range_get)
		# 到目标点距离
		res=[]
		Position.all.each do |s|
			jl = ((s.x-x)**2 + (s.y-y)**2)**0.5
			if(jl < range_get*3)
				res << s.sound
			end
		end
		return res
	end
end