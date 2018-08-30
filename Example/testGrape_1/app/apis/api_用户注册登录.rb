#
# 用户注册、登录示例
# cookie 会话
#
class API < Grape::API
	format :json

#
# 用户管理帮助
#
	helpers do
	#
	# 设置cookie , 参数是cookie的value
	#
		def setCookie token
			cookies[:token] = { value: token, expires: 1.minutes.from_now.utc, domain: '192.168.3.19', path: '/' }
		end

	#
	# 通过headers['Cookie']判断是否登录，是返回user并更新cookie时间，否返回false
	#
		def signin?
			# headers['Cookie'] 或 cookies[:token]为空时返回 false
			if cookies[:token] && !headers['Cookie'].nil?
				# 处理一下headers['Cookie']，用来与cookies[:token]比较
				str = headers['Cookie']
				str = str[str.index('=')+1...str.length]
				# headers['Cookie'] 与 cookies[:token] 内容不同时返回 false
				if cookies[:token].eql?(str)
					# 用 headers['Cookie'] 生成token,从数据库中取user
					user = User.find_by(token: Digest::SHA1.hexdigest(str))
						# 获取不到user时返回 false ,否则返回user
						if user 
							# 更新cookie时间，防止过期
							setCookie cookies[:token]
							# 返回user
							user
						else
							false	# => user 为空
						end
				else
					false # => token 不匹配
				end
			else
				false	# => token 或 cookie 为空
			end
		end # => def

		def signin user
			# 创建token
  		rtoken = SecureRandom.urlsafe_base64 # => 加密字符串 "jnzwx4mT0u99hAtjWtFLfw"
			# 塞进cookie
			setCookie rtoken
			# 把明文字符加密后塞进数据库，用于查找
			user.update(token: Digest::SHA1.hexdigest(rtoken).to_s)
		end

	end # => helpers

#
# 用户注册
#
	desc '注册'
	params do
		requires :name, type: String, desc: "User name."
		requires :password, type: String, desc: "Password."
		requires :password_confirmation, type: String, desc: "password_confirmation."
	end
	post :signup do
		user = User.create(params)
		if user
			# 直接登录
			signin user
  	else
  		# 返回错误信息
  		error!('401 Unauthorized', 401)
  	end
	end

#
# 用户登录
#
	desc '登录'
	params do
		requires :name, type: String, desc: "User name."
		requires :password, type: String, desc: "Password."
	end
	post :signin do
		# 验证用户名密码
  	user = User.find_by(name: params[:name]).try(:authenticate, params[:password])
  	if user
  		signin user
  	else
  		# 返回错误信息
  		 error!('401 Unauthorized', 401)
  	end
	end

#
# 模拟用户登录后的访问
#
	get :userinfo do
		p signin?
	end

#
# 用户登出
#
	desc '登出'
	delete :signout do
		cookies.delete(:token) # if signin?
	end

end

=begin

####	Model format ####

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :token

      t.timestamps
    end
  end
end