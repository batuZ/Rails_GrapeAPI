require 'rails_helper'

RSpec.describe Sound, type: :request do

	before :each do
  		@user = User.create(userName: 'test', password: '123456', password_confirmation: '123456')
  		post '/session', :params => {userName: @user.userName, password: @user.password}
  		@token = JSON.parse(response.body)['token']
  end

  describe '#request' do

  	it '创建sound POST /user/sounds' do
  		post '/user/sounds', :params => {token: @token, uuid: 'UUIDx', url: 'URLx'}
			expect(response.status).to be == 200
			expect(@user.sounds.count).to be == 1
			expect(JSON.parse(response.body)['sound_id']).to be == @user.sounds.first.id
  	end

  	context '#测试已存在的sound' do
  		before :each do
  			@sound = @user.sounds.create!(uuid: 'testUUID',url: 'testURL')
  		end

  		it '更新一个不存在的sound' do
  			put '/user/sounds/987', :params => {token: @token,uuid: 'UID',url: 'URL'}
  			expect(response.status).to be == 404
  		end

  		it '更新sound成功测试' do
  			put "/user/sounds/#{@sound.id}", :params => {token: @token, uuid: 'newUUID', url: 'newURL'}
  			expect(response.status).to be == 200
  			@sound.reload
  			expect(@sound.uuid).to be == 'newUUID'
  			expect(@sound.url).to be == 'newURL'
  		end

  		it '测试删除sound成功' do
  			delete "/user/sounds/#{@sound.id}", :params => {token: @token}
  			expect(response.status).to be == 200
  			expect(@user.sounds.count).to be == 0
  		end

  		it '测试获取sound成功' do
		  	sound = @user.sounds.create!(uuid: 'testUUID',url: 'testURL')
				get "/user/sounds/#{sound.id}", :params => {token: @token}
				expect(response.status).to be == 200
				body = JSON.parse(response.body)
				expect(body['uuid']).to be == sound.uuid
				expect(body['url']).to be == sound.url
			end

			it '测试获取User的sound集合' do
				get '/user/sounds', :params => {token: @token}
				expect(response.status).to be == 200
				body = JSON.parse(response.body)
				expect(body['sounds'].size).to be == 1
				expect(body['sounds'][0]['uuid']).to be == @sound.uuid
				expect(body['sounds'].first['url']).to be == @sound.url
  		end
  	end
  end
end
