class StatusManager < Grape::API
	require 'statusmanager_helpers.rb'
	require 'usermanager_helpers.rb'
	helpers StatusManagerHelpers, UserManagerHelpers

desc '更新当前状态'
	params do
		requires :x,:y, type: Float
	end
	get :updateStatus do
		user = signin?
		if(user)
			sounds = find_my_sounds_byJuLi(params[:x], params[:y], user.range_get)
			data=[]
			sounds.each do |s|
				data << {
					url: s.url,
					uuid: s.uuid,
					s_type: s.s_type,
					x: s.position.x,
					y: s.position.y,
					z: s.position.z
				}
			end
			data
		else
			p 'testforit...'
			p headers['Cookie']
		end
	end
end