module UserManagerHelpers
# 设置 cookies
	def setCookie token
		cookies[:token] = { value: token, expires: 1.minutes.from_now.utc, domain: '192.168.3.19', path: '/' }
	end

# 通过headers['Cookie']判断是否登录，是返回user并更新cookie时间，否返回false
	def signin?
		# headers['Cookie'] 或 cookies[:token]为空时返回 false
		if cookies[:token] && headers['Cookie'] 
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
						setCookie(cookies[:token])
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

# 登录助手
	def signin user
		if user 
			rtoken = SecureRandom.urlsafe_base64
			setCookie(rtoken)
			user.update(token: Digest::SHA1.hexdigest(rtoken).to_s)
			true
		else
			false
		end
	end

end