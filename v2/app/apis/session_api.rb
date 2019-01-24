class SessionAPI < Grape::API
	resources :session do
		params do
			requires(:userName, :password, type: String)
		end
		post do # 登陆
			status 200
			user = User.find_by(userName: params['userName'])
			if user && user.authenticate(params['password'])
				# 把用户id 加密为 token
				{token: JWT.encode({user_id: user.id}, 'key')}
			else
				{error: '用户不存在或密码错误'}
			end
		end
	end
end