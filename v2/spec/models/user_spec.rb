require 'rails_helper'

RSpec.describe User do

	describe '#Model',type: :model do
		before :each do
			@user = User.create(userName: 'test', password: '123456', password_confirmation: '123456')
		end

		it '验证密码' do
			# 密码正确
			expect(@user.authenticate('123456')).to be @user
			# 密码错误
			expect(@user.authenticate('111111')).to be false
		end

		it '验证数据库中取用户' do
			iuser = User.find_by(userName: @user.userName)
			expect(iuser.authenticate('123456').id).to be == @user.id
		end

	end
	
	describe '#request', type: :request do

		it '注册用户 POST /user' do
			post '/user', :params => {userName: 'test', password: '123456'}
			expect(response.status).to be == 200
			body = JSON.parse(response.body)
			expect(body['success']).to be true 
			expect(User.count).to be == 1
		end

		it '测试用户名为空或被占用' do
			user = User.create(userName: 'test', password: '123456', password_confirmation: '123456')
			post '/user', :params => {userName: 'test', password: '123456'}
			expect(response.status).to be == 200
			body = JSON.parse(response.body)
			expect(body['error']).to_not be_nil
			expect(User.count).to be == 1
		end

		it '测试缺少参数，如：密码为空' do
			post '/user', :params => {userName: 'test'}
			expect(response.status).to be == 400
			expect(User.count).to be == 0
		end

		# it '测试更新用户正确 PUT /user' do

		# end
	end

end