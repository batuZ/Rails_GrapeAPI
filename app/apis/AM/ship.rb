module AM
	class Ship < Grape::API

		get 'ship_hello' do 
			'AM_ship'
		end

	end
end