class GirlAPI < Grape::API
	format :json

	get 'hellogirl' do
		'girl'
	end
	# try:
  	# http://localhost:3000/girl/hellogirl
  	
end