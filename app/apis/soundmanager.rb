class SoundManager < Grape::API
	require 'soundmanager_helpers.rb'
	require 'usermanager_helpers.rb'
	helpers SoundManagerHelpers, UserManagerHelpers


desc '设置一个声音，塞进数据库'
	## activeStorage 资料：https://edgeguides.rubyonrails.org/active_storage_overview.html
	params do
		requires(:uuid, :url, type: String) 
		requires(:x, :y, :z, type: Float)
		# requires(:s_type, type: Integer)
	end
	post :setSound do
		## 接收信息,拿到用户
		user = signin?
		if user
		## 创建sound
			sound = user.sounds.create(uuid: params[:uuid], url: params[:url])
			
			sound.create_position(x:params[:x], y:params[:y], z:params[:z])
			## 接收上传的声音文件 
			# tag = params[:sfile]

			## 把文件绑定到sound上
			# sound.sfile.attach(
			# 	io: File.open(tag[:tempfile].path),
			# 	filename: tag[:filename],
			# 	content_type: tag[:type]
			# 	)

			##清掉临时文件
			# tag[:tempfile].unlink
				## 返回是否成功，是：绘在UI上，否：不绘
			# sound.sfile.attached?
			p '>>>>>>>>>>>>'
			pp user
			pp sound
			pp sound.position
			p "sound.cound = #{Sound.count}"
			p '>>>>>>>>>>'
		else

		end
	end

end