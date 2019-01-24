class User < ApplicationRecord
	validates :userName, :presence => {:message => '用户不能为空'},:uniqueness => {:message => '用户名已存在！'}  
  has_secure_password  	# 密码验证
  has_many :sounds
end
