require 'rails_helper'

RSpec.describe SessionAPI do
	
	describe '#request', type: :request do

		before :each do
  		@user = User.create(userName: 'test', password: '123456', password_confirmation: '123456')
  	end

		it '登录正常 POST /session'  do
			post '/session', :params => {userName: @user.userName, password: @user.password}
			expect(response.status).to be == 200
			token = JSON.parse(response.body)['token']
			# 解码 token 为用户id
			payload,_ = JWT.decode(token,'key');
			expect(payload['user_id']).to be == @user.id
		end

		it '测试密码错误' do
			post '/session', :params => {userName: @user.userName, password: '错误密码'}
			expect(response.status).to be == 200
			body = JSON.parse(response.body)
			expect(body['error']).to_not be_nil
			expect(body['token']).to be_nil
		end

	end

end