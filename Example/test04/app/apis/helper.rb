class PointF
	attr_accessor :x, :y, :z, :range

	# 通过传入的坐标和范围，在数据库中找到相交的记录并返回
	def find_my_sounds coor

		# 范围的包围盒求交，就是最大最小值
		p minx = coor.x - coor.range
		p miny = coor.y - coor.range
		p maxx = coor.x + coor.range
		p maxy = coor.y + coor.range

		alls = Sound.all
		res=[]
		alls.each do |s|
			if s.position.x>minx and s.position.x<maxx and s.position.y>miny and s.position.y<maxy
				res << s
			end
		end
		p res.count
		return res
		# 中心点半径求交，也就是圆求交
	end
end