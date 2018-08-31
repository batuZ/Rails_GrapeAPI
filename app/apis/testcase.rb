class TestCase < Grape::API
	require 'usermanager_helpers.rb'
	helpers UserManagerHelpers

	get :test do 
		signin?
	end
	
	post :test do
	end
	
end