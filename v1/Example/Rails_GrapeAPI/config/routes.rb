Rails.application.routes.draw do
	# 一、以api为前缀，不同功能通过模块管理
  	mount API => '/api'

  	# 二、以功能命名API，独立定义
  	mount BoyAPI => '/boy'
  	mount GirlAPI => '/girl'
  	mount ManAPI => '/man'

  	# 三、定义不同层级的API
  	mount Color::RedAPI => '/color'

end
