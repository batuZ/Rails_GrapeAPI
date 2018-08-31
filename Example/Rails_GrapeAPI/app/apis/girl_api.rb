class GirlAPI < Grape::API
	format :json

	# http://localhost:3000/girl/hellogirl
	get 'hellogirl' do
		'girl'
	end
  	

	################## 请求参数 ################

	# header参数 http://localhost:3000/girl/header_value
	get 'header_value' do
		data = {
			'header_val' => headers,
			"PI" => headers['Myparam']
		}
	end
	# {
	#   "header_val": {
	#     "Version": "HTTP/1.1",
	#     "Cache-Control": "no-cache",
	#     "Postman-Token": "97ba6223-b478-4c66-9889-ad3961ddccb0",
	#     "Myparam": "3.141592654",
	#     "User-Agent": "PostmanRuntime/3.0.11-hotfix.2",
	#     "Accept": "*/*",
	#     "Host": "localhost:3000",
	#     "Accept-Encoding": "gzip, deflate",
	#     "Connection": "keep-alive"
	#   },
	#   "PI": "3.141592654"
	# }


	# body参数
	# path param 在地址中，是地址的一部分，一般为ID或索引
	# url param 在地址后，以？隔开，键值对形式出现，一般用于搜索
	# field param 隐藏在请求中的键值对，可承载大数据，不支持get动作
	# http://localhost:3000/girl/params_value?urlpam=AAA
	post 'params_value' do
		data = {
			'header_val' => params,
			"urlPam" => params['urlpam'],
			"fieldPam" => params['fieldpam']
		}
	end
	# {
	#   "header_val": {
	#     "urlpam": "AAA",
	#     "fieldpam": "BBB"
	#   },
	#   "urlPam": "AAA",
	#   "fieldPam": "BBB"
	# }  	


	
end