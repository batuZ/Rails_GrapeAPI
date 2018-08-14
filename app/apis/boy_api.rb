class BoyAPI < Grape::API
	format :json

	get 'helloboy' do
		'boy'
	end
	# try:
  	# http://localhost:3000/boy/helloboy
  	
end