class VERSION_1::Api_v1 < Grape::API
	post 'login' do 
	end

	get 'logout' do
	end

	get 'updateStatus' do
	end

	post 'setSound' do
	end

	get :josn_case do
		## 接收
		arr = Sound.first(3)

		## 返回
		data=[]
		arr.each do |s|
			data << {
				:id => s.id,
				:url => s.url,
				:user => User.find(s.user_id).name
			}
  		end
  		data.to_json
	end
	
end