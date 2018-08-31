module BM
	class Ship < Grape::API

		get 'ship1_hello' do 
			'BM_ship'
		end

	end
end