class UserManager < Grape::API
	require 'usermanager_helpers.rb'
	helpers UserManagerHelpers

desc '用户注册'
	params do
		requires(:name, :password, :password_confirmation, type: String) 
	end
	post :signup do
		user = User.new(params)
		userInfo(user) if signin(user) if user.save

	end

desc '用户登录'
	params do
		requires(:name, :password, type: String)
	end
	post :signin do
		user = User.find_by(name: params[:name]).try(:authenticate, params[:password])
	 	userInfo(user) if signin(user)
	end

desc '更新用户信息'
	get :userinfo do
		userInfo(signin?)
	end

desc '用户登出'
	delete :signout do
		cookies.delete(:token) # if signin?
	end

desc '修改密码'
	params do
		requires(:oldpassword, :password, :password_confirmation, type: String)
	end
	post :changepassword do
		user = signin?
		user.update(params) if(user.authenticate(params[:oldpassword])) if(user)
	end
end