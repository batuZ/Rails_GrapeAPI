require 'Entities.rb'

class API < Grape::API
	format :json

	helpers do

		# 验证token
		def authenticate_user!
			begin
				payload, _ = JWT.decode(params['token'],'key')
				@current_user = User.find(payload['user_id']) #找不到会抛异常
			rescue StandardError
			end
			# 中断并返回错误
			error!({error: 'unauthorized access'},401) if @current_user.nil? 
		end

		# 获取当前用户
		def current_user
			@current_user
		end

	end

	mount UserAPI
	mount SessionAPI
	mount SoundAPI

	# 测试 grape-entity
	get :users do
		present User.all, with: UserEnt
	end

# points ---------------------- line ----------------

	# 获取app请求中的头部信息
	post :getHeaderInfo do
		# 首字母大写
		headers['Token']
	end

	# 设置服务器响应中的头部信息
	post :setHeaderInfo do
		header('API-Token', 'asdfasdfasdf')
		{res:true}
	end

	# 没有可以响应的接口时，调用此endpoint
	route :any, '*path' do
	  # error! # or something else
	  {message: '没有可以响应的接口'}
	end

	# error
	get :errorAction do
		# 终断后续动作，并返回401
		error!({error: 'unauthorized access'},401) if params['pam'] == '3'
		# 所以动作已完成，并返回结果，结果为错误信息，返回码为200
		status 200
		{error: 'error message'} if params['pam'] == '2'
	end
  
  # 过滤参数，一般用于更新model
  params do
  	requires(:name,:email,type: String)
  end
  get :showInfo do
  	declared(params)
  end
  #request : '/showInfo?name=user&email=3322@qq.com&sex=boy'
  #response: {name: user, email: 3322@qq.com},与参数验证器相同
end