require './app/apis/helper.rb'
module VERSION_1
	class Api < Grape::API

		##
		## 健壮参数
		##
		params do
			requires :x,:y,:z, type: Float
			optional :msg, tpye: String, defaule: "null"
		end
		
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
		## activeStorage 资料：https://edgeguides.rubyonrails.org/active_storage_overview.html
		post :setSound do
			## 接收信息,拿到用户
			user = User.find(params[:user])	# 这里不能为空
			## 创建sound
			sound = user.sounds.create(url: params[:url])
			## 设置sound位置
			point = PointF.new params[:x].to_f, params[:y].to_f, params[:z].to_f, params[:range].to_f
			sound.create_position(x:point.x, y:point.y, z:point.z)
			## 接收上传的声音文件 
			tag = params[:sfile]
			## 把文件绑定到sound上
			sound.sfile.attach(
				io: File.open(tag[:tempfile].path),
				filename: tag[:filename],
				content_type: tag[:type]
				)
			##清掉临时文件
			tag[:tempfile].unlink
 			## 返回是否成功，是：绘在UI上，否：不绘
			sound.sfile.attached?
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