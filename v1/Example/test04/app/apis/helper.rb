class PointF
	attr_accessor :x, :y, :z, :range
	def initialize x, y, z, range
		@x = x
		@y = y
		@z = z
		@range = range
	end
end

# 通过传入的坐标和范围，在数据库中找到相交的记录并返回
def find_my_sounds coor

	# 范围的包围盒求交，就是最大最小值
	minx = coor.x - coor.range
	miny = coor.y - coor.range
	maxx = coor.x + coor.range
	maxy = coor.y + coor.range

	alls = Position.all
	res=[]
	alls.each do |s|
		if s.x > minx and s.x < maxx and s.y > miny and s.y < maxy
			res << s.sound
		end
	end
	return res
	# 中心点半径求交，也就是圆求交
end
