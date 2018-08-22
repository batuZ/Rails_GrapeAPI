class API < Grape::API
	format :json
	# mount VERSION_2::Test_case
	# mount VERSION_1::Test_case 

	mount VERSION_2::Api
	mount VERSION_1::Api

end