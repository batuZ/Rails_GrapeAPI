module AM
	class Car < Grape::API

		get 'car_hello' do 
			'car'
		end

	end
end