class API < Grape::API

	# >>> 版本控制
	# version 'v1', using: :header, vendor: 'twitter'

	# >>> 路由前缀
	prefix :api

	# >>> 返回格式
	format :json


	# >>> 辅助方法,放一些共用的函数，比如验证身份
  helpers do
    def test
    	'I am helper : '
    end
	end
	# or mix in a module 'StatusHelpers'
	# module StatusHelpers
	# 	def user_info(user)
	# 	  "#{user} has statused #{user.statuses} status(s)"
	# 	end
	# end
  # helpers StatusHelpers


	# >>> 接口说明
	desc "This is a test"
	# root URL Action
	get '/' do 
		test + 'test'
	end


	# >>> 参数限制，要求输入的参数必须合法
	# 可以写在某Action前面,针对每个action进行限制
	params do # => 约束:userAge中的params
		# 必须传入string类型的name参数
		requires :name, type: String, desc: "User name."
		# name的值不能为空
		requires :name, allow_blank: false
	end
	get :userAge do 
		params[:name]
	end

	params do # => 约束:userName中的params
		# 必须传入int类型的user_id
		requires :user_id, type: Integer, desc: "User id."
		# 限制传入值的范围
		optional :user_id, values: 0..89
	end
	post :userName, requirements: { user_id: /[0-9]*/ } do #Regexp 条件过滤
		params[:user_id]
	end


	# >>> 通过route_param可以定义一个路由参数作为命名空间
	route_param :id do
		get do
		  Status.find(params[:id])
		end
	end


	# >>> 嵌套路由
	resource ':father' do
		# ':father'将匹配URL中users位置的字符，':father' => 'users'
		# 例： localhost:3000/api/users => "I am helper : get :users"
		get do 
			test + 'get :' + params[:father]
		end
		post do 
			test + 'post :' + params[:father]
		end

		# :fa_id将匹配URL中47位置的字符，:fa_id => 47
		# 例： localhost:3000/api/users/47 => ""I am helper : 47""
		get ':fa_id' do
			test + params[:fa_id]
		end

		# 二层嵌套，并不推荐
		resource ':fa_id' do
			get do 
				test + params[:fa_id]
			end
			post do
				test + params[:fa_id]
			end
		end# => resource ':fa_id'

	end# => resource ':father'


	# >>> Post中的文件
	params do
  	requires :avatar, type: File
	end
	post :createItem do 
		params[:avatar][:filename] 	# => 'avatar.png'
	  params[:avatar][:type] 			# => 'image/png'
	  params[:avatar][:tempfile] 	# => #<File>
	end

end