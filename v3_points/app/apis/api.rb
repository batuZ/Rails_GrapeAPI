require 'grape-swagger'
class API < Grape::API
	format :json

	mount V1::Gr

	add_swagger_documentation(
	  base_path: "/api",
	  hide_documentation_path: true,
	  hide_format: true,
	)
	desc 'aaaaaaaaaa'	
	get :test_params do
		params
	end
	get :test_headers do
		headers
	end
	post :test_headers do
		error!({error: 'unauthorized access'},401) if params['pam'] == '3'
		{error: 'error message'} if params['pam'] == '2'
		{res: {head: headers, body: params}}
	end

		params do
				# 用户更新的内容以json格式的字符串传入，然后转换为Hash
				requires(:token, type: String)
				# requires(:user_info, type: String)
				requires(:user_info, type: Hash) do
					optional :name
					optional :email
				end
			end
			put do #更新用户
				status 200
				authenticate_user!
				declared(params['user_info'])
				# 这里很不安全，user的任何属性字段都可以传进来进行修改，包括原本应该是只读的
				# user_i = JSON.parse(params['user_info']) 
			end# => put do



# endline --------------------------------
	route :any, '*path' do
	  # error! # or something else
	  {message: '没有可以响应的接口'}
	end
end