# Rails_GrapeAPI

### 创建一个 rails 工程

		rails new Grape_1 --skip-bundle
		修改 gemfile:
			source 'https://gems.ruby-china.org'
			gem 'grape'
		bundle

### 创建api文件、文件夹

		app/apis 必须
		app/apis/man_api.rb      根据rails约定，对应的类名和路由都必须为 ManAPI

### 测试代码

		app/apis/man_api.rb :
		``` ruby

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