#
# 用户注册、登录示例
#

class API < Grape::API
	format :json

	#
	# 用户注册
	#
	params do
		requires :name, type: String, desc: "User name."
		requires :password, type: String, desc: "Password."
	end
	post :login do 
  	user = User.find_by(name: params[:name]).try(:authenticate, params[:password])
  	user ? user : :null
	end

	#
	# 用户登录
	#
	params do
		requires :name, type: String, desc: "User name."
		requires :password, type: String, desc: "Password."
		requires :password_confirmation, type: String, desc: "password_confirmation."
		optional :tel, type: Integer, default: 18600009999
	end
	post :register do
		user = User.create(params)
		user.id ? user : :null
	end
	
end