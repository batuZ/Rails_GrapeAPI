class ManAPI < Grape::API
	format :json

	get 'helloman' do
		'man'
	end
	# try:
  	# http://localhost:3000/man/helloman
  	
end