class API < Grape::API
	format :json

	helpers do
		# 验证token
		def authenticate_user!
			begin
				payload, _ = JWT.decode(params['token'],'key')
				@current_user = User.find(id: payload['user_id']) #找不到会抛异常
			rescue StandardError
			end
			error!({error: 'unauthorized access'},401) if @current_user.nil?
		end
		# 获取当前用户
		def current_user
			@current_user
		end
	end

	mount UserAPI
	mount SessionAPI
	
	params do
		requires(:message, type: String) 
	end
	get 'test' do
		status 200
		{message: "#{params['message']}"}
	end
end