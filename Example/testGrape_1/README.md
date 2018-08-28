# 简洁的应用流程和部份功能演示



### 创建工程

		rails new testGrape_1 --skip-bundle --api

### 设置gemfile:
		source 'https://gems.ruby-china.com'
		gem 'grape'
		bundle

### 创建API目录,并设置路径

		/app/apis

		在/config/application.rb增加：

		config.paths.add "app/apis", glob: "**/*.rb"
		config.autoload_paths += Dir["#{Rails.root}/app/apis/*"]

### 设置路由
	
		mount   Twitter::API  => '/'

### 启动设置

		/config.ru 修改为

		#run Rails.application
		run API

### 编写 api.rb

``` ruby
class API < Grape::API
	format :json
	get '/' do 
		'test'
	end
end
```
		
	测试：	http://loaclhost:3000

