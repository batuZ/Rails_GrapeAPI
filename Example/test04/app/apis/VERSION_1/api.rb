require './app/apis/helper.rb'
module VERSION_1
	class Api < Grape::API

		##
		## 更新当前状态
		## 
		get :updateStatus do
			## 接收
			point = PointF.new params[:x].to_f, params[:y].to_f, params[:z].to_f, params[:range].to_f

			## 调方法计算距离
			sounds = find_my_sounds point
			
			## 返回
			data=[]
				sounds.each do |s|
					data << {
						url: s.url,
							x: s.position.x,
							y: s.position.y,
							z: s.position.z
					}
				end
			data.as_json
		end

		##
		## 设置一个声间，塞进数据库
		##
		post :setSound do
			## 接收
			user = User.find(params[:user])	# 这里不能为空
			url = params[:url]							# 这里要有file
			point = PointF.new params[:x].to_f, params[:y].to_f, params[:z].to_f, params[:range].to_f	#这里的坐标不对会塞入000

			## 返回是否成功，是：绘在UI上，否：不绘
		  res =	user.sounds.create(url: url).create_position(x:point.x, y:point.y, z:point.z)
		end

		##
		## 登录
		##
		post :login do 

		end

		##
		## 登出
		##
		get :logout do
		end

		##
		## 测试
		##
		get :json_case do
		end
	end
end