class UserAPI < Grape::API

	resources :user do

		params do
			requires(:userName, :password, type: String) 
		end
		post do	# 注册
			status 200
			user = User.new(params)
			if user.save
				{success: true}
			else
				{error: user.errors.full_messages}
			end
		end

		before do
			authenticate_user! #in helper
		end
		params do
			requires(:token, :userBio, type: String) 
		end
		put do #更新用户
			if current_user.update(params['userBio']) #in helper
				{success: true}
			else
				{error: current_user.errors.full_messages}
			end# => if
		end# => put

	end# => user

end# => class