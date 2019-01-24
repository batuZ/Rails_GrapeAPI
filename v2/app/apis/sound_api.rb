class SoundAPI < Grape::API

	resources :user do

		params do
			requires :token, type: String
		end

		resources :sounds do

			before do
				authenticate_user!
			end
			params do
				requires(:uuid, :url, type: String)
			end
			post do #创建
				status 200
				sound = current_user.sounds.build(uuid: params[:uudi],url: params[:url])
				if sound.save
					{sound_id: sound.id}
				else
					{error: sound.errors.full_messages}
				end
			end

			get do #获取User的所有sound
				{sounds: current_user.sounds}
			end

			group ':id' do

				helpers do

					def set_sound!
						@current_sound = current_user.sounds.where(id:params[:id]).first
						error!({error: 'not found'},404) if@current_sound.nil?
					end

					def current_sound
						@current_sound
					end

				end

				before do
					set_sound!
				end

				params do
					requires(:uuid, :url, type: String)
				end

				put do	#更新
					if current_sound.update(uuid: params['uuid'],url: params['url']) 
						{success:true}
					else
						{error:current_sound.errors.full_messages}
					end
				end

				delete do #删除
					if current_sound.destroy
						{success: true}
					else
						{error: current_sound.errors.full_messages}
					end
				end

				get do # 获取
					{uuid: current_sound.uuid, url: current_sound.url}
				end

			end

		end

	end

end