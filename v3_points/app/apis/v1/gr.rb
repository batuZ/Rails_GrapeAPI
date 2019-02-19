module V1
	class Gr < Grape::API

		version 'v1', using: :path


		get :haha do
			'haha'
		end

				add_swagger_documentation(
			# :api_version => "api/v1",
   #    hide_documentation_path: true,
			hide_format: true
			)

	end
end