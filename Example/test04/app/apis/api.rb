class API < Grape::API
	format :json
	#版本控制
	mount VERSION_2::Api
	mount VERSION_1::Api
end