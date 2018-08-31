class UserManager < Grape::API
	require 'usermanager_helpers.rb'
	helpers UserManagerHelpers

desc '用户注册'
	params do
		requires :name, type: String, desc: "User name."
		requires :password, type: String, desc: "Password."
		requires :password_confirmation, type: String, desc: "password_confirmation."
	end
	post :signup do
		user = User.create(params)
		if user
			signin user
  	else
  		error!('401 Unauthorized', 401)
  	end
	end

desc '用户登录'
	params do
		requires :name, type: String, desc: "User name."
		requires :password, type: String, desc: "Password."
	end
	post :signin do
  	user = User.find_by(name: params[:name]).try(:authenticate, params[:password])
  	if user
  		signin user
  	else
  		 error!('401 Unauthorized', 401)
  	end
	end

desc '模拟用户登录后的访问'
	get :userinfo do
		p signin?
	end

desc '用户登出'
	delete :signout do
		cookies.delete(:token) # if signin?
	end

end