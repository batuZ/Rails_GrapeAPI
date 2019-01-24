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


# Rail API 方法参考：
# Rails 使用 Rails 构建 API 实践 kayakjiang · kayakjiang · 2015年05月31日 · 最后由 judi0713 回复于 2018年03月20日 · 44702 次阅读
# https://ruby-china.org/topics/25822

# RSpec 单元测试
# grape api单元测试
# https://blog.csdn.net/shiralwz/article/details/49075307
# https://github.com/rspec/rspec-rails
# https://relishapp.com/rspec/rspec-rails/docs

# Grape 文档翻译版
# http://xiajian.github.io/2014/10/24/grade

# Grape 视频
# https://www.jikexueyuan.com/course/grape/