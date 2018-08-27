# Rails_GrapeAPI

### 创建一个 rails 工程

		rails new Grape_1 --skip-bundle
		修改 gemfile:
			source 'https://gems.ruby-china.org'
			gem 'grape'
		bundle

### 创建api文件、文件夹

		app/apis
		//根据rails约定，对应的类名和路由都必须为 ManAPI
		app/apis/man_api.rb      
### 测试代码

app/apis/man_api.rb :
``` ruby
require './vendor/libs/hand'
# 引用功能模块
# './' 是rails工程的根目录
class ManAPI < Grape::API
	format :json
	get 'hello' do
		'hello'
	end
end

```

config/routes.rb  ：
``` ruby
	mount ManAPI => '/man'
```

### 测试API

		http://localhost:3000/man/hello
		
		
		
		
----
# Rails_API

rails 自带的API模式

### 创建工程

	# 简化工程模版，controller 继承自API
	rails new myPro --api

### 创建主接入点

	在./app/controllers/application_controller.rb 中加一个方法：
``` ruby
class ApplicationController < ActionController::API
	def baseFunc
		#request.request_method # => GET/POST/PUT/DELETE
		#request.headers[:token] # => header field
		#params # => params
		@params	= params	
		self.send(params[:command])
		#self.send(params[:command],params)
		# k = self.method(params[:command])
		# k.call(params)
	end
end
```

### 创建 API 控制器

	.> rails g controller api
	
	# 写个测试方法
``` ruby
class ApiController < ApplicationController
	def test
		render json: @params
	end
end
```

### 设置路由

``` ruby
match '/api/:command' => 'api#baseFunc', via: :all
```


### 测试接口

		http://localhost:3000/api/test
	
		
