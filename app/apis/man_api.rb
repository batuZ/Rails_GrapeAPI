class ManAPI < Grape::API
	format :json

	# http动作

	# 获取数据
	get 'helloman' do
		'get man'
	end
	
	# 创建数据
	post 'createman' do
  		'create a man'
	end

	# 更新数据
	put 'updateman' do
		'update man'
	end

	# 删除数据
	delete 'deleteman' do
		'delete man'
	end


	###############  UTC 时间戳 ######################

	get 'utcTime' do
		data = {
			'create_at'=>Time.new.utc,
			'update_at'=>Time.new.utc
		}
	end
	# {
	#   "create_at": "2018-08-14T10:38:45.452Z",
	#   "update_at": "2018-08-14T10:38:45.452Z"
	# }

	############### 响应码 ##################
	# 200 Get请求成功完成
	# 201 Post Put Delete 请求成功完成
	# 202 Post Put Delete Patch 请求成功完成,马上进行异步处理
	# 400 请求无效
	# 401 请求失败，因没有通过认证
	# 403 请求失败，因没有权限
	# 429 请求频率超配
	# 500 服务器问题

	# 定制响应码,三位数
	get 'testcodes' do
		status 314 
	end

	################ 定制error ########################

   get 'testerror' do
    	error!('where is my TT?', 324)
   end

end