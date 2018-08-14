class Color::RedAPI < Grape::API
	format :json
	get 'red' do
		'red'
	end
end