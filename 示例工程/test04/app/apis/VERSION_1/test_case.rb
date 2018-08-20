module VERSION_1
	class Test_case < Grape::API
		get 'case' do 
			'case_v1'
		end
	end
end