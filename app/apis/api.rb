class API < Grape::API
	format :json

# 用户管理模块
	require 'usermanager.rb'
	mount UserManager

# 声音管理模块
	require 'soundmanager.rb'
	mount SoundManager

# 状态管理模块
	require 'statusmanager.rb'
	mount StatusManager

# 测试模块
	require 'testcase.rb'
	mount TestCase

end