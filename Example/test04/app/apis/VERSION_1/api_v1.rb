require './app/apis/helper.rb'
module VERSION_1
	class Api_v1 < Grape::API
		post :login do 
		end

		get 'logout' do
		end

		get 'updateStatus' do

		end

		post 'setSound' do
		end

		get :json_case do
			## 接收
			point = PointF.new
			point.x = params[:x].to_f
			point.y = params[:y].to_f
			point.z = params[:z].to_f
			point.range = params[:range].to_f
			
			## 调方法计算距离
			point.find_my_sounds point
			
			## 返回
			# data=[]
			# arr.each do |s|
			# 	data << {
			# 		:id => s.id,
			# 		:url => s.url,
			# 		:user => User.find(s.user_id).name
			# 	}
	  # 		end
	  # 		data.as_json
		end
	end
end