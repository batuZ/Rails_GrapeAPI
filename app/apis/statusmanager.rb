require 'api_helpers.rb'
class StatusManager < Grape::API
	require 'statusmanager_helpers.rb'
	helpers StatusManagerHelpers

desc '更新当前状态'
	params do
		requires :x,:y,:z,:range, type: Float
	end
	get :updateStatus do
		point = PointF.new params[:x].to_f, params[:y].to_f, params[:z].to_f, params[:range].to_f
		sounds = find_my_sounds point
		data=[]
		sounds.each do |s|
			data << {
				url: s.url,
					x: s.position.x,
					y: s.position.y,
					z: s.position.z
			}
		end
		data.as_json
	end
end